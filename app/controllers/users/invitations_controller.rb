class Users::InvitationsController < Devise::InvitationsController
    skip_before_filter :authenticate_user!, :only => [ :edit, :update ]

    def edit
        super
        @user = resource
        @user
    end

    def update
        self.resource = resource_class.accept_invitation!(params[resource_name])

        Rails.logger.debug "resource validity: #{resource.valid?.inspect}"
        if resource.errors.empty?
            unless resource.valid? && process_payment(resource)
                respond_with_navigational(resource){ render :edit }
                return
            end

            set_flash_message :notice, :updated
            sign_in(resource_name, resource)
            respond_with resource, :location => after_accept_path_for(resource)
        else
            respond_with_navigational(resource){ render :edit }
        end
    end

    protected
        def process_payment(user)
            # uncomment for testing
            # Bypasses Payment Process entirely (for fast testing)
            #@user.build_team :name => "#{@user.username.capitalize}'s Team"
            #return @user.save!

            # strip params specific to the user's billing info
            same_billing_address = !!(params.delete('same_billing_address') { false })
            cc_params = params.delete 'credit_card'

            # Create Credit Card Object
            credit_card ||= ActiveMerchant::Billing::CreditCard.new(
                  :number => cc_params['card_num'],
                  :verification_value => cc_params['card_code'],
                  :month => cc_params['expiration_month'],
                  :year => cc_params['expiration_year'],
                  :first_name => cc_params['first_name'],
                  :last_name => cc_params['last_name']
            )

            # Wrap Credit Card in Payment
            payment = { :credit_card => credit_card }
            puts 'PAYMENT:'
            Rails.logger.debug payment
            puts ''

            # Create Address
            address = {
                  :first_name => user.first_name,
                  :last_name => user.last_name,
                  :country => user.address.country,
                  :phone => user.phone,
                  :address => "#{user.address.street} #{user.address.street2}",
                  :city => user.address.city,
                  :state => user.address.state,
                  :zip => user.address.zip
            }
            puts 'USER ADDRESS:'
            pp address
            puts ''

            # Create Payment Profile from form data
            # this uses the billing address and credit card data
            profile = {
                :merchant_customer_id => user.id, # Optional
                :description => user.full_name,
                :email => user.email,
                :payment_profiles => {
                    :bill_to => address,
                    :payment => payment
                }
            }

            # Call the authorize.net API to create the profile
            options = { :profile => profile }
            puts 'OPTIONS:'
            Rails.logger.debug options
            puts ''

            create_profile_response = GATEWAY.create_customer_profile(options)
            pp 'create customer profile response:'
            pp create_profile_response
            Rails.logger.debug 'response.authorization (customer payment profile id):'
            Rails.logger.debug create_profile_response.authorization
            puts ''

            #save the customer profile id
            #make sure this is not overwritten
            if create_profile_response.success?
                # save the returned customer payment profile ID
                user.customer_profile_id = create_profile_response.authorization

                # NOW GET THE CUSTOMER PROFILE & CREATE THE TRANSACTION
                profile_options = { :customer_profile_id => user.customer_profile_id }
                profile_response = GATEWAY.get_customer_profile(profile_options)

                # Get the customer payment profile id for transaction
                @customer_payment_profile_id = profile_response.params['profile']['payment_profiles']['customer_payment_profile_id']
                puts "customer_payment_profile_id: #{@customer_payment_profile_id}"
                puts ''

                # build the transaction object
                # TODO: refactor this - get amount from params
                #:amount => (@user.tier == 'legend' ? 500 : 250)
                @transaction = {
                    :type => :auth_capture,
                    :amount => (user.tier == 'legend' ? '0.02' : '0.01'),
                    :customer_profile_id => user.customer_profile_id,
                    :customer_payment_profile_id => @customer_payment_profile_id
                }

                ## Perform the transaction
                @transaction_response = GATEWAY.create_customer_profile_transaction(:transaction => @transaction)
                puts 'transaction response:'
                Rails.logger.debug @transaction_response
                puts ''
                if @transaction_response.success?
                    user.build_team :name => "#{user.username.capitalize}'s Team"
                    return true
                else
                    user.errors[:payment] << 'Something went wrong with the transaction'
                    set_flash_message :error, 'payment.transaction.error'
                end
            else
                user.errors[:payment] << 'Something went wrong with creating the user profile'
                set_flash_message :error, 'payment.profile.error'
            end
            false
        end
end

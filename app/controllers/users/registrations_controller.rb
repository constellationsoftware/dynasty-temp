module Users
    class RegistrationsController < Devise::RegistrationsController
        skip_before_filter :authenticate_user!, :only => [ :create ]
        skip_before_filter :check_registered_league

        def create
            build_resource

            if resource.valid? && process_payment(resource) && resource.save
                if resource.active_for_authentication?
                    set_flash_message :notice, :signed_up if is_navigational_format?
                    sign_in(resource_name, resource)
                    respond_with resource, :location => after_sign_up_path_for(resource)
                else
                    set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
                    expire_session_data_after_sign_in!
                    respond_with resource, :location => after_inactive_sign_up_path_for(resource)
                end
            else
                clean_up_passwords resource
                respond_with resource
            end
        end

        def update
            self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

            if resource.valid? && process_payment(resource) && resource.update_with_password(resource_params)
                if is_navigational_format?
                    if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
                        flash_key = :update_needs_confirmation
                    end
                    set_flash_message :notice, flash_key || :updated
                end
                sign_in resource_name, resource, :bypass => true
                respond_with resource, :location => after_update_path_for(resource)
            else
                clean_up_passwords resource
                respond_with resource
            end
        end

        def edit
            #5.times{ @user.event_subscriptions.build }
            #DynastyEvent.reflect_on_association(:event_subscriptions).options[:conditions] = "#{DynastyEventSubscription.table_name}.user_id = #{@user.id}"
            #@notification_settings = DynastyEvent.joins{[ event_subscriptions.outer, event_subscriptions.user.outer ]}.eager_load{[ event_subscriptions, event_subscriptions.user ]}
        end

        def after_sign_up_path_for(resource)
            # send out welcome email
            Users::Mailer.welcome(resource).deliver
            super
        end
=begin
        def clean_select_multiple_params(hash = params)
            puts hash.inspect
            hash.each do |k, v|
                case v
                    when Array then v.reject!(&:blank?)
                    when Hash then clean_select_multiple_params(v)
                end
            end
        end
=end
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
                pp payment
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

                # assume we're encountering this again because of incorrect customer information
                # and delete the customer profile before recreating them
                unless user.customer_profile_id.nil?
                    delete_profile_response = GATEWAY.delete_customer_profile :customer_profile_id => user.customer_profile_id
                    pp 'delete customer profile response:'
                    pp delete_profile_response

                    if delete_profile_response.success?
                        user.customer_profile_id = nil
                        user.save
                    else
                        set_flash_message :error, 'payment.profile_delete.error'
                        user.errors[:payment] << 'Something went wrong with deleting the user profile'
                    end
                end

                # Call the authorize.net API to create the profile
                options = { :profile => profile }
                #save the customer profile id
                #make sure this is not overwritten
                puts 'OPTIONS:'
                pp options
                puts ''

                create_profile_response = GATEWAY.create_customer_profile(options)
                pp 'create customer profile response:'
                pp create_profile_response
                puts 'response.authorization (customer payment profile id):'
                pp create_profile_response.authorization
                puts ''

                if create_profile_response.success?
                    # save the returned customer payment profile ID
                    user.customer_profile_id = create_profile_response.authorization
                    user.save
                else
                    set_flash_message :error, 'payment.profile_create.error'
                    user.errors[:payment] << 'Something went wrong with creating the user profile'
                    return false
                end
=begin
                    # attempt to update the customer profile with all new data
                    profile[:customer_profile_id] = user.customer_profile_id
                    options = { :profile => profile }
                    puts 'OPTIONS:'
                    pp options
                    puts ''

                    update_profile_response = GATEWAY.update_customer_profile(options)
                    pp 'update customer profile response:'
                    pp update_profile_response
                    puts 'response.authorization (customer payment profile id):'
                    pp update_profile_response.authorization
                    puts ''

                    unless update_profile_response.success?
                        set_flash_message :error, 'payment.profile_update.error'
                        user.errors[:payment] << 'Something went wrong with updating the user profile'
                        return false
                    end
=end

                # NOW GET THE CUSTOMER PROFILE & CREATE THE TRANSACTION
                profile_options = { :customer_profile_id => user.customer_profile_id }
                profile_response = GATEWAY.get_customer_profile(profile_options)
                if profile_response.success?
                    # Get the customer payment profile id for transaction
                    @customer_payment_profile_id = profile_response.params['profile']['payment_profiles']['customer_payment_profile_id']
                    puts "customer_payment_profile_id: #{@customer_payment_profile_id}"
                    puts ''
                else
                    set_flash_message :error, 'payment.profile_fetch.error'
                    user.errors[:payment] << 'Something went wrong with fetching the user profile'
                    return false
                end

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
                pp @transaction_response
                puts ''
                if @transaction_response.success?
                    user.build_team :name => "#{user.username.capitalize}'s Team"
                    user.save
                    return true
                else
                    set_flash_message :error, 'payment.transaction.error'
                    user.errors[:payment] << 'Something went wrong with processing the transaction'
                    return false
                end
                false
            end
    end
end

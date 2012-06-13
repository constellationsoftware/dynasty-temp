module Users
    class RegistrationsController < Devise::RegistrationsController
        skip_before_filter :check_registered_league

        def create
            # strip params specific to the user's billing info
            same_billing_address = !!(params.delete('same_billing_address') { false })
            cc_params = params.delete 'credit_card'
            super

            if @user.valid?
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
                      :first_name => @user.first_name,
                      :last_name => @user.last_name,
                      :country => @user.address.country,
                      :phone => @user.phone,
                      :address => "#{@user.address.street} #{@user.address.street2}",
                      :city => @user.address.city,
                      :state => @user.address.state,
                      :zip => @user.address.zip
                }
                puts 'USER ADDRESS:'
                pp address
                puts ''

                # Create Payment Profile from form data
                # this uses the billing address and credit card data
                profile = {
                    :merchant_customer_id => @user.id, # Optional
                    :description => @user.full_name,
                    :email => @user.email,
                    :payment_profiles => {
                        :bill_to => address,
                        :payment => payment
                    }
                }

                # Call the authorize.net API to create the profile
                options = { :profile => profile }
                puts 'OPTIONS:'
                pp options
                puts ''

                create_profile_response = GATEWAY.create_customer_profile(options)
                pp 'create customer profile response:'
                pp create_profile_response
                puts 'response.authorization (customer payment profile id):'
                pp create_profile_response.authorization
                puts ''

                #save the customer profile id
                #make sure this is not overwritten
                if create_profile_response.success?
                    # save the returned customer payment profile ID
                    @user.customer_profile_id = create_profile_response.authorization
                    if @user.save!
                        # NOW GET THE CUSTOMER PROFILE & CREATE THE TRANSACTION
                        profile_options = { :customer_profile_id => @user.customer_profile_id }
                        profile_response = GATEWAY.get_customer_profile(profile_options)

                        # Get the customer payment profile id for transaction
                        @customer_payment_profile_id = profile_response.params['profile']['payment_profiles']['customer_payment_profile_id']
                        puts 'customer_payment_profile_id'
                        pp @customer_payment_profile_id
                        puts ''

                        # build the transaction object
                        # TODO: refactor this - get amount from params
                        #:amount => (@user.tier == 'legend' ? 500 : 250)
                        @transaction = {
                              :type => :auth_capture,
                              :amount => "0.01",
                              :customer_profile_id => @user.customer_profile_id,
                              :customer_payment_profile_id => @customer_payment_profile_id
                        }

                        ## Perform the transaction
                        @transaction_response = GATEWAY.create_customer_profile_transaction(:transaction => @transaction)
                        if @transaction_response.success?
                            team = @user.build_team
                            team.name = "#{@user.username.capitalize}'s Team"
                            team.save!
                        end
                    end
                end
            end
            #cc = CreditCard.new(cc_params)
            #pp cc.serialize
            #if @user.valid? && cc.valid?
            #    # process the transaction here
            #end
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
    end
end

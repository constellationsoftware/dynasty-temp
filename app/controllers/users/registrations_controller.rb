module Users
    class RegistrationsController < Devise::RegistrationsController

        def create
            # strip params specific to the user's billing info
            same_billing_address = !!(params.delete('same_billing_address') { false })
            cc_params = params.delete 'credit_card'
            super

            if @user.valid?

                # Create Credit Card Object
                    @credit_card  ||= ActiveMerchant::Billing::CreditCard.new(
                          :number             => cc_params['card_num'],
                          :verification_value => cc_params['card_code'],
                          :month              => cc_params['expiration_month'],
                          :year               => cc_params['expiration_year'],
                          :first_name         => cc_params['first_name'],
                          :last_name          => cc_params['last_name']
                    )

                # Wrap Credit Card in Payment
                    @payment = {
                        :credit_card => @credit_card
                    }
                    pp @payment

                # Create Address
                    @address = {
                        :first_name =>  params['user']['first_name'],
                        :last_name  =>  params['user']['last_name'],
                        :country    =>  "USA",
                        :phone      =>  params['user']['phone'],
                        :address    =>  params['user']['street'],
                        :city       =>  params['user']['city'],
                        :state      =>  params['user']['state'],
                        :zip        =>  params['user']['zip']
                    }
                    pp "ADDRESS:"
                    pp @address

                # Create Payment Profile from form data
                # this uses the billing address and credit card data
                    @profile = {
                          :merchant_customer_id => params['user']['email'], # Optional
                          :description => "#{params['user']['first_name']} #{params['user']['last_name']}",
                          :email => params['user']['email'],
                          :payment_profiles => {
                            :bill_to => @address,
                            :payment => @payment
                            }
                    }

                    profile = @profile

                # Call the authorize.net API to create the profile
                    @options = {
                          :profile => @profile
                    }
                    pp "OPTIONS:"
                    pp @options

                    response = GATEWAY.create_customer_profile(@options)
                    pp "create customer profile response:"
                    pp response
                    "response.authorization (customer payment profile id):"
                    pp response.authorization

                #save the customer profile id
                #make sure this is not overwritten
                    params['user']['customer_profile_id'] = response.authorization
                    @customer_profile_id = params['user']['customer_profile_id']

                # NOW GET THE CUSTOMER PROFILE & CREATE THE TRANSACTION
                     @options = {
                         :customer_profile_id => params['user']['customer_profile_id']
                     }
                     @response = GATEWAY.get_customer_profile(@options)
                     # Get the customer payment profile id for transaction
                     @customer_payment_profile_id = @response.params['profile']['payment_profiles']['customer_payment_profile_id']
                     pp @customer_payment_profile
                     # build the transaction object
                     # TODO: refactor this - get amount from params
                     @transaction = {
                         :type => :auth_capture,
                         :amount => "0.01",
                         :customer_profile_id => @customer_profile_id,
                         :customer_payment_profile_id => @customer_payment_profile_id
                     }

                    ## Perform the transaction
                     @transaction_response = GATEWAY.create_customer_profile_transaction(:transaction => @transaction)

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
    end
end

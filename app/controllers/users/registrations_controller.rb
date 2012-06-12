module Users
    class RegistrationsController < Devise::RegistrationsController
        def create

            # Initialize ActiveMerchant (duplicated currently)
            ActiveMerchant::Billing::Base.mode = :test
            gateway = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
                :login => "325XVk2Wr7",
                :password => "37QL56N92fXMhPf2"
            )

            # strip params specific to the user's billing info
            same_billing_address = !!(params.delete('same_billing_address') { false })
            cc_params = params.delete 'credit_card'

            super


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
            #
            cc_params['email'] = @user.email
            cc_params['phone'] = @user.phone
            if same_billing_address
                cc_params['address'] = "#{@user.address.street} #{@user.address.street2}"
                cc_params['city'] = @user.address.city
                cc_params['state'] = @user.address.state
                cc_params['zip'] = @user.address.zip
            end

            @address = {
                :street1    =>  @user.address.street,
                :street2    =>  @user.address.street2,
                :city       =>     @user.address.city,
                :state      =>    @user.address.state,
                :zip        =>      @user.address.zip
            }

            # Create Payment Profile from form data
            # this uses the billing address and credit card data

            @profile = {
                  :merchant_customer_id => @user.id, # Optional
                  :description => "#{@user.first_name} #{@user.last_name}",
                  :email => @user.email,
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
            pp @options

            # response = gateway.create_customer_profile(@options)

            # pp response

            # @amount = 250
            # pp @amount
            # credit card
            #cc = CreditCard.new(cc_params)




            #if @user.valid? && @credit_card.valid?
            #     # process the transaction here
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

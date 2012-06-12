module Users
    class RegistrationsController < Devise::RegistrationsController
        def create
            # strip params specific to the user's billing infp
            same_billing_address = !!(params.delete('same_billing_address') { false })
            cc_params = params.delete 'credit_card'
            super

            # create Payment Profile from form data


            # create CreditCard from form data
            cc_params['email'] = @user.email
            cc_params['phone'] = @user.phone
            if same_billing_address
                cc_params['address'] = "#{@user.address.street} #{@user.address.street2}"
                cc_params['city'] = @user.address.city
                cc_params['state'] = @user.address.state
                cc_params['zip'] = @user.address.zip
            end
            cc = CreditCard.new(cc_params)
            pp cc.serialize
            if @user.valid? && cc.valid?
                # process the transaction here
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

module Users
    class RegistrationsController < Devise::RegistrationsController
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

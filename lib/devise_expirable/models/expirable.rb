module Devise
    module Models
        module Expirable
            extend ActiveSupport::Concern

            module InstanceMethods
                # Tells if the account has expired
                #
                # @return [bool]
                def expired?
                    # expired_at set (manually, via cron, etc.)
                    return self.expired_at >= Time.now.utc unless self.expired_at.nil?
                    true
                end

                # Overwrites active_for_authentication? from Devise::Models::Activatable
                # for verifying whether a user is active to sign in or not. If the account
                # is expired, it should never be allowed.
                #
                # @return [bool]
                def active_for_authentication?
                    super# && !self.expired?
                end

                # The message sym, if {#active_for_authentication?} returns +false+. E.g. needed for i18n.
                def inactive_message
                    !self.expired? ? super : :expired
                end
            end

            module ClassMethods
                ::Devise::Models.config(self, :expired)

                # Scope method to collect all expired users since +time+ ago
                def expired
                    exp_month = Date::MONTHNAMES.find_index Settings.user.expiry_month
                    exp_day = Settings.user.expiry_day
                    exp_year = Season.current.year
                    exp_datetime = DateTime.new exp_year, exp_month, exp_day
                    where('expired_at IS NULL OR expired_at < ?', exp_datetime)
                end
            end
        end
    end
end

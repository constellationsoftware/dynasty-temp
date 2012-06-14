module Users
    class SessionsController < Devise::SessionsController
        skip_before_filter :check_registered_league


        def after_sign_in_path_for(resource)
            return root_path
        end
    end
end

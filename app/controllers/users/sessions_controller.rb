module Users
    class SessionsController < Devise::SessionsController
        def after_sign_in_path_for(resource)
            return root_path
        end
    end
end

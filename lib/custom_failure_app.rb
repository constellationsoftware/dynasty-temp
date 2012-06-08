class CustomFailureApp < Devise::FailureApp
    def redirect
        message = warden.message || warden_options[:message]
        if message == :timeout
            redirect_to attempted_path
        elsif message == :expired
            redirect_to order_path
        else
            super
        end
    end
end

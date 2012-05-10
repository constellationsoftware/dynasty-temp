
class UsersController < InheritedResources::Base
    before_filter :authenticate_user!
    before_filter :signed_in_user, only: [:edit, :update]
    before_filter :correct_user,   only: [:edit, :update]

    def test_mail
        @user = current_user

        Users::Mailer.welcome(@user).deliver
=begin
        puts "https://api:#{$MAILGUN_API_KEY}@api.mailgun.net/v2/samples.mailgun.org/messages"
        RestClient.post("https://api:#{$MAILGUN_API_KEY}" \
            "@dynastyowner.mailgun.org/v2/samples.mailgun.org/messages",
            :address => @user.email,
            :description => "Mailgun developers list")
=end
    end

    def index
        @users = User.all
    end

    private
        module SessionsHelper

            def redirect_back_or(default)
                redirect_to(session[:return_to] || default)
                clear_return_to
            end

            def store_location
                session[:return_to] = request.fullpath
            end

            private

            def clear_return_to
                session.delete(:return_to)
            end
        end
end

class UserMailer < ActionMailer::Base
    layout 'email'
    default :from => 'noreply@dynastyowner.mailgun.org'

    def welcome(user)
        @user = user
        @url = new_user_session_path
        mail :to => @user.email,
             :subject => 'Welcome to Dynasty Owner!',
             :template_path => 'users/mailer',
             :template_name => 'welcome'
    end

    class Preview < MailView
        def welcome
            user = User.first
            ::UserMailer.welcome(user)
        end
    end
end

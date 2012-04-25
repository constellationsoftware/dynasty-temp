class Users::Mailer < ActionMailer::Base
    include Devise::Mailers::Helpers

    layout 'email'
    default :from => 'noreply@dynastyowner.net'

    def welcome(user)
        #attachments.inline['navbar_logo.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'navbar_logo.png'))

        @user = user
        @login_path = new_user_session_url
        mail(:to => @user.email,
             :subject => 'Welcome to Dynasty Owner!',
             :template_path => 'users/mailer',
             :template_name => 'welcome') do |format|
            format.html
            format.text
        end
    end

    class Preview < MailView
        def welcome
            user = User.first
            Users::Mailer.welcome(user)
        end
    end
end

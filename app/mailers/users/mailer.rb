class Users::Mailer < ActionMailer::Base
    include Devise::Mailers::Helpers

    layout 'email'
    default :from => 'noreply@dynastyowner.net'

    def welcome(user)
        #attachments.inline['navbar_logo.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'navbar_logo.png'))

        @user = user
        @login_path = new_user_session_url
        mail(:to => @user.email,
             :subject => I18n.t(:subject, :scope => %w( devise mailer welcome ), :name => @user.first_name),
             :template_path => 'users/mailer',
             :template_name => 'welcome') do |format|
            format.html
            format.text
        end
    end

    def invitation_instructions(user)
        @resource = user
        mail(:to => @resource.email,
             :subject => I18n.t(:subject, :scope => %w( devise mailer invitation_instructions )),
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

        def invitation
            user = User.first
            invitor = User.new :first_name => 'Joe', :last_name => 'Blow'
            invitor.build_team :name => 'Test Team'
            invitor.team.build_league :name => 'Test League'
            user.invitor = invitor
            user.message = 'Test Message'
            Users::Mailer.invitation_instructions(user)
        end
    end
end

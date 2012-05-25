class UsersController < ApplicationController
    before_filter :authenticate_user!

    def home
        @team = current_user.team
        @league = current_user.team.league unless @team.nil?
        unless @league.nil? || @league.teams.count < Settings.league.capacity
            last_draft_day = Season.current.start_date.at_beginning_of_week(:tuesday)
            dates = (last_draft_day.advance(:weeks => -1)..last_draft_day)
            @draft_date_collection = {}
            dates.each do |date|
                @draft_date_collection[date.strftime(I18n.t 'draft_date_format', :scope => 'user_cp')] = date
            end
            @draft = @league.draft.nil? ? @league.build_draft(:start_datetime => dates.first) : @league.draft
        end
    end

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
end

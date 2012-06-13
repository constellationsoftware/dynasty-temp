class UsersController < ApplicationController
    before_filter :authenticate_user!
    before_filter :signed_in_user, only: [ :edit, :update ]
    before_filter :correct_user,   only: [ :edit, :update ]

    helper :authorize_net
    helper_method :payment_step_class, :league_step_class, :team_step_class

    def home
        @user = current_user
        @team = @user.team
        @league = @team.league unless @team.nil?
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





    def order
        @user = current_user

        # stub out a league and draft in case the user wishes to create a private league
        @league = nil
        if @user.team.league_id?
            @league = @user.team.league
        else
            @league = @user.team.build_league :name => "#{@user.username.capitalize}'s League", :public => false
            last_draft_day = Season.current.start_date.at_beginning_of_week(:tuesday)
            dates = (last_draft_day.advance(:weeks => -1)..last_draft_day)
            @draft_date_collection = {}
            dates.each{ |date|
                @draft_date_collection[date.strftime(I18n.t 'draft_date_format', :scope => 'user_cp')] = date
            }
            @league.build_draft(:start_datetime => dates.first) if @league.draft.nil?
        end

        # payment stuff
        @title = 'Sign up for the 2012-2013 Season'
        @amount = 275.00
        @purchase_type = "item1<|>2012-2013 Season Membership<|>275.00<|>N"
        @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => payments_relay_response_url(:only_path => false))
    end

    def process_payment

    end

    def accept_invitation

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

    def index
        @users = User.all
    end

    def payment_step_class(user)
        cls = []
        if user.team.league_id?
            cls << 'btn-success'
        else
            cls << 'btn-default' if user.expired?
        end
        cls << 'disabled' unless user.team.league_id.nil?
        cls
    end

    def league_step_class(user)
        cls = []
        if user.team.league_id?
            cls << 'btn-success'
        else
            cls << 'btn-default' if user.expired?
        end
        cls << 'disabled' if user.team.league_id.nil?
        cls
    end

    def team_step_class(user)
        cls = []
        cls << 'btn-default' if user.expired?
        cls << 'disabled' if user.team.league_id.nil?
        cls
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

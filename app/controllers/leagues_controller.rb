class LeaguesController < ApplicationController
    respond_to :html, :json

    skip_before_filter :check_registered_league, :only => [ :join, :join_invite, :create ]

    def join
        @league = League.where{ teams_count < Settings.league.capacity }.first
        @league ||= create_league
        join_league
        redirect_to edit_my_team_path
    end

    def join_invite
        @league = current_user.invited_by.team.league
        join_league
        # send out confirmation email to invitor
        redirect_to edit_my_team_path
    end

    def create
        params[:league][:public] = 0
        params[:league][:tier] = current_user.tier
        @league = create_league
        join_league
        if @league
            # send out invite emails
            invite_emails = params.delete('league-invite').reject{ |email| email.nil? || email === '' }
            message = params.delete('message')
            invite_emails.each do |email|
                user = User.invite! :email => email, :tier => current_user.tier do |u|
                    u.invitor = current_user
                    u.message = message
                end
                user.update_attribute :invited_by, current_user if user
            end
            redirect_to edit_my_team_path
        end
    end

    def edit
        @league = resource
        if @league.teams.count === Settings.league.capacity
            last_draft_day = Season.current.start_date.at_beginning_of_week(:tuesday)
            dates = (last_draft_day.advance(:weeks => -1)..last_draft_day)
            @draft_date_collection = {}
            dates.each do |date|
                @draft_date_collection[date.strftime(I18n.t 'draft_date_format', :scope => 'user_cp')] = date
            end
            @league.build_draft(:start_datetime => dates.first) if @league.draft.nil?
        end
    end

    def update
        @league = resource
        unless @league.nil?
            @league.update_attributes! params[:league]
            redirect_to root_path
        end
    end

    protected
        def create_league
            league = League.new params[:league]
            if league.save!
                # league creator is assigned the manager role
                current_user.add_role 'manager', league
            end
            league
        end

        def join_league
            unless @league.teams.include? current_user.team
                @league.teams << current_user.team
                League.increment_counter :teams_count, @league.id
            end
        end

        def collection
            if !!params[:page] && !!params[:limit]
                @leagues = end_of_association_chain
                @total = @leagues.size
                @leagues = @leagues.page(params[:page]).per(params[:limit])
            else
                @leagues = end_of_association_chain
            end
        end

    def resource
        current_user.team.league
    end
end

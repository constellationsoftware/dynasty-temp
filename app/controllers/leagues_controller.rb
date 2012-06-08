class LeaguesController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html, :json

    def join
        @league = League.where{ teams_count < Settings.league.capacity }.first
        @league ||= create_league
        join_league
    end

    def create
        @league ||= create_league(false)
        join_league
    end

    def edit
        @league = resource
        if @league.teams.count === Settings.league.capacity
            last_draft_day = Season.current.start_date.at_beginning_of_week(:tuesday)
            dates = (last_draft_day.advance(:weeks => -1)..last_draft_day)
            @draft_date_collection = {}
            dates.each{ |date|
                @draft_date_collection[date.strftime(I18n.t 'draft_date_format', :scope => 'user_cp')] = date
            }
            @league.build_draft(:start_datetime => dates.first) if @league.draft.nil?
        end
    end

    def update
        @league = resource
        unless @league.nil?
            if params[:league].has_key? :draft_attributes
                # delete main attribute since values are handled through JS
                params[:league][:draft_attributes].delete :start_datetime
            end
            @league.update_attributes! params[:league]
            redirect_to root_path
        end
    end

    protected
        def create_league(public = true)
            league = League.new params[:league]
            league.public = public
            if league.save!
                # league creator is assigned the manager role
                current_user.add_role 'manager', league
            end
            league
        end

        def join_league
            @league.teams << current_user.team
            League.increment_counter :teams_count, @league.id
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

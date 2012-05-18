class LeaguesController < InheritedResources::Base
    before_filter :authenticate_user!
    respond_to :html, :json

    def new
        @league = League.new :password => Forgery::Basic.password
        respond_with @league
    end

    def create
        @league = League.new(params[:league])
        if @league.save!
            current_user.add_role 'manager', @league
            current_user.team.league_id = @league.id
            current_user.team.save
            redirect_to root_path
        end
    end

    def edit
        edit! do
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
    end

    def update
        @league = League.find(params[:id])
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
        def collection
            if !!params[:page] && !!params[:limit]
                @leagues = end_of_association_chain
                @total = @leagues.size
                @leagues = @leagues.page(params[:page]).per(params[:limit])
            else
                @leagues = end_of_association_chain
            end
        end
end

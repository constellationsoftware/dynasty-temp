class LeaguesController < InheritedResources::Base
    before_filter :authenticate_user!
    respond_to :html, :json

    has_scope :with_manager, :type => :boolean

    def create
        create! do |success, failure|
            resource.public = false
            resource.manager = current_user
            resource.save
            success.html{ redirect_to root_path }
        end
    end

    def edit
        edit! do
            if @league.teams.count === Settings.league.capacity
                dates = (Season.current.start_date.prev_week(:friday)..Season.current.start_date.prev_week(:sunday))
                @draft_date_collection = {}
                dates.each{ |date|
                    @draft_date_collection[date.strftime(I18n.t 'draft_date_format', :scope => 'user_cp')] = date
                }
                draft = @league.build_draft(:start_datetime => dates.first) if @league.draft.nil?
            end
        end
    end

    def update
        if @league = League.find(params[:id])
            if params[:league].has_key? :draft_attributes
                # delete main attribute since values are handled through JS
                params[:league][:draft_attributes].delete :start_datetime
            end
            @league.update_attributes! params[:league]
            respond_with @league
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

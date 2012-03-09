class League::PlayersController < SubdomainController
    before_filter :authenticate_user!, :get_team!, :only => [ :index, :list_by_points ]

    custom_actions :collection => [ :list_by_points ]
    respond_to :json

    has_scope :available, :type => :boolean, :only => :index do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.available(team.league.draft)
    end
    has_scope :with_contract, :type => :boolean
    has_scope :with_points, :type => :boolean
    has_scope :with_points_from_season, :default => 'current' do |controller, scope, value|
        scope.with_points_from_season(value)
    end
    has_scope :roster, :only => :index, :type => :boolean do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.roster(team)
    end
    # TODO: move this to the league roster controller
    has_scope :drafted, :only => :index, :type => :boolean do |controller, scope|
        team = controller.instance_variable_get("@team")
        league = team.league
        scope.drafted(league)
    end
    has_scope :with_position, :type => :boolean
    has_scope :filter_positions, :type => :boolean, :only => :index do |controller, scope, value|
        # if a filter is defined, we use that
        filter = nil
        if !!controller.params[:filter]
            filterObj = ActiveSupport::JSON.decode(controller.params[:filter])
            filter = filterObj.collect { |x|
                x['property'] === 'position' ? x['value'] : nil
            }.compact
        end
        team = controller.instance_variable_get("@team")
        scope.filter_positions(team, filter).with_name
    end
    has_scope :with_name
    has_scope :by_name, :allow_blank => true, :only => :index do |controller, scope, value|
        scope.with_name.by_name(value)
    end
    has_scope :ordered_by_points, :only => :index do |controller, scope|
        scope.order{ points.points.desc }
    end
    has_scope :with_favorites, :type => :boolean, do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.with_favorites(team)
    end

    # Session Storage using ActiveRecord
    # session :session_key => '_dynasty_session_id'


    protected
        def collection
            if !!params[:page] && !!params[:limit]
                @players = end_of_association_chain
                @total = @players.size
                @players = @players.page(params[:page]).per(params[:limit])
            else
                @players = end_of_association_chain
            end
        end

    private
        def get_team!
            @team = UserTeam.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
        end
end

class League::PlayersController < SubdomainController
    before_filter :authenticate_user!
    before_filter :get_team!, :only => :index

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
    has_scope :by_name, :allow_blank => true, :only => :index do |controller, scope, value|
        scope.with_name.by_name(value)
    end
    has_scope :order_by, :only => :index do |controller, scope, value|
        sort_hash = ActiveSupport::JSON.decode(value)
        sort_str = sort_hash.collect { |key, value|
            value = 'ASC' if !value
            "#{key} #{value}"
        }.join(', ')
        scope.order(sort_str)
    end

    def show
        show! do |format|
            @player = @player.flatten
            format.json{ render :json => @player }
        end
    end|

    def index
        index! do |format|
            players = @players.collect { |player| player.flatten }

            result = {
                :success => true,
                :players => players,
                :total => @total
            }
            format.json { render :json => result }
        end
    end

    protected
    def collection
        if (!!params[:page] and !!params[:limit])
            @players = end_of_association_chain.page(params[:page]).per(params[:limit])
        else
            @players = end_of_association_chain
        end
        @total = @players.size
    end

    private
    def get_team!
        @team = UserTeam.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
    end
end

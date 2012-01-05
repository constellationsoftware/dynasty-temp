class League::PlayersController < SubdomainController
  before_filter :authenticate_user!
  before_filter :get_team!, :only => :index

  respond_to :json

  has_scope :available, :type => :boolean, :only => :index
  has_scope :with_contract, :type => :boolean
  has_scope :with_points, :type => :boolean
  has_scope :roster, :only => :index, :type => :boolean do |controller, scope|
    scope.roster(controller.current_user)
  end
  has_scope :filter_positions, :type => :boolean, :only => :index do |controller, scope, value|
    # if a filter is defined, we use that
    filter = nil
    if !!controller.params[:filter]
      filterObj = ActiveSupport::JSON.decode(controller.params[:filter])
      filter = filterObj.collect{ |x|
        x['property'] === 'position' ? x['value'] : nil
      }.compact
    end
    team = controller.instance_variable_get("@team")
    scope.filter_positions(team, filter).joins{name}.includes{name}
  end
  has_scope :by_name, :allow_blank => true, :only => :index do |controller, scope, value|
    scope.by_name(value)
  end
  has_scope :order_by, :only => :index do |controller, scope, value|
    sort_hash = ActiveSupport::JSON.decode(value)
    sort_str = sort_hash.collect{ |key, value|
      value = 'ASC' if !value
      "#{key} #{value}"
    }.join(', ')
    scope.order(sort_str)
  end

  # also have this in the draft model for now
  def get_normalized_player_object(player)
    obj = {
      :id => player.id,
      :full_name => player.name.full_name,
      :first_name => player.name.first_name,
      :last_name => player.name.last_name,
      :position => (player.position.nil?) ? '' : player.position.abbreviation.upcase,
      :contract_amount => player.contract.amount
    }

    if player.respond_to?('points') and player.points.length > 0
      obj = obj.merge({
        :points => player.points.first.points,
        :defensive_points => player.points.first.defensive_points,
        :fumbles_points => player.points.first.fumbles_points,
        :passing_points => player.points.first.passing_points,
        :rushing_points => player.points.first.rushing_points,
        :sacks_against_points => player.points.first.sacks_against_points,
        :scoring_points => player.points.first.scoring_points,
        :special_teams_points => player.points.first.special_teams_points,
        :games_played => player.points.first.games_played
      })
    end

    return obj
  end

  def index
    index! do |format|
      players = @players.collect{ |player| get_normalized_player_object(player) }

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
        @players = end_of_association_chain
          .page(params[:page])
          .per(params[:limit])
      else
        @players = end_of_association_chain
      end
      @total = @players.size
    end

  private
    def get_team!
      @team = UserTeam.where{(league = @league) & (user = @current_user)}.first
    end
end

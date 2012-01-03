class League::PlayersController < SubdomainController
  before_filter :authenticate_user!
  before_filter :get_team!, :only => [:index, :search]

  custom_actions :collection => :search
  respond_to :json

  defaults :resource_class => Player, :collection_name => 'players', :instance_name => 'player'
  has_scope :by_rating, :type => :boolean, :only => :index
  has_scope :by_position, :only => :index, :type => :boolean do |controller, scope|
    scope.by_position(!!(controller.params[:filter]) ? ActiveSupport::JSON.decode(controller.params[:filter]) : nil)
  end
  has_scope :available, :type => :boolean, :only => [ :index, :search ]
  has_scope :roster, :only => :index, :type => :boolean do |controller, scope|
    scope.roster(controller.current_user)
  end
  has_scope :weighted, :type => :boolean, :default => true do |controller, scope, value|
    team = controller.instance_variable_get("@team")
    scope.weighted(team)
  end
  has_scope :by_name, :only => :search do |controller, scope, value|
    query = scope.joins{name}.order{[name.last_name, name.first_name]}
    query = query.where{name.full_name.like "%#{value}%"} unless value.nil?
  end
  has_scope :order_by do |controller, scope, value|
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
      :contract_amount => player.contract.amount,
      :points => (player.weighted_points.nil?) ? 0 : player.weighted_points
    }
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

  def search
    search! do |format|
      players = @players
        .joins{position}
        .collect{ |player| get_normalized_player_object(player) }

      result = {
        :success => true,
        :players => players,
        :total => @total
      }
      format.json { render :json => result }
    end
  end

  def is_filtered
    return (!!params[:filter])
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

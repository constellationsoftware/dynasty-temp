class League::PlayersController < InheritedResources::Base
  before_filter :authenticate_user!

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
  has_scope :by_name, :only => :search do |controller, scope, value|
    scope.joins{name}.where{name.full_name.like "%#{value}%"}.order('full_name ASC')
  end

  # also have this in the draft model for now
  def get_normalized_player_object(player)
    obj = {
      :id => player.id,
      :full_name => player.name.full_name,
      :position => (player.position.nil?) ? '' : player.position.abbreviation.upcase,
      :contract_amount => player.contract.amount,
      :points => (player.points.nil?) ? 0 : player.points.points
    }
  end

  def index
    index! do |format|
      players = []
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
      players = @players.joins{position}.collect{ |player| get_normalized_player_object(player) }

      result = {
        :success => true,
        :players => players,
        :total => @total
      }
      format.json { render :text => result.to_json }
    end
  end

  def is_filtered
    return (!!params[:filter])
  end

  protected
    def collection
      @players = end_of_association_chain

      if (!!params[:page] and !!params[:limit])
        @players = end_of_association_chain
          .page(params[:page])
          .per(params[:limit])
      else
        @players = @players.all
      end
      @total = @players.size
    end
end

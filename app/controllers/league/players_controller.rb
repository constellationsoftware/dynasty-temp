class League::PlayersController < InheritedResources::Base
  before_filter :authenticate_user!

  custom_actions :collection => :search
  respond_to :json

  defaults :resource_class => Salary, :collection_name => 'players', :instance_name => 'player'
  has_scope :by_rating, :type => :boolean, :only => :index
  has_scope :by_position, :only => :index, :type => :boolean do |controller, scope|
    scope.by_position(!!(controller.params[:filter]) ? ActiveSupport::JSON.decode(controller.params[:filter]) : nil)
  end
  has_scope :available, :type => :boolean, :only => [ :index, :search ]
  has_scope :roster, :only => :index, :type => :boolean do |controller, scope|
    scope.roster(controller.current_user)
  end
  has_scope :by_name, :only => :search do |controller, scope, value|
    scope.where{full_name.like "%#{value}%"}.order('full_name ASC')
  end

  def index
    index! do |format|
      result = {
        :success => true,
        :players => @players,
        :total => @total
      }
      format.json { render :text => result.to_json }
    end
  end

  def search
    search! do |format|
      result = {
        :success => true,
        :players => @players,
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
      @total = @players.size
      if (!!params[:page] and !!params[:limit])
        @players = end_of_association_chain
          .page(params[:page])
          .per(params[:limit])
      end
    end
end

class League::TeamsController < SubdomainController
  before_filter :authenticate_user!

  actions :index, :balance
  has_scope :draft_data, :type => :boolean, :default => true, :only => :index
  respond_to :json

  def index
    index! do |format|
      result = {
        :success => true,
        :teams => @teams
      }
      format.json { render :text => result.to_json(
        :except => [ :league_id, :uuid ],
        :include => {
          :picks => { :except => [ :draft_id ] }
        }
      )}
    end
  end

  def balance
    #team = UserTeam
  end

  def collection
    @teams = @league.draft.teams
  end
end

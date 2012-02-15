class League::AutoPicksController < SubdomainController
    before_filter :authenticate_user!
    before_filter :get_team!, :only => :index

    def index
        @auto_picks = AutoPick.order("sort_order ASC").find_all_by_user_team_id(@team.id)

    end

    def sort
        AutoPick.transaction do
            AutoPick.connection.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE")
            params[:auto_pick].each_with_index do |id, index|
                AutoPick.update_all({sort_order: index+1}, {id: id})
            end
        end
        render nothing: true
    end
    private
        def get_team!
            @team = UserTeam.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
        end
end

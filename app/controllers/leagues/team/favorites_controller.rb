class Leagues::Team::FavoritesController < SubdomainController
    before_filter :authenticate_user!, :get_team_id!

    def sort
        Favorite.transaction do
            Favorite.connection.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE")
            params[:auto_pick].each_with_index do |id, index|
                Favorite.update_all({sort_order: index+1}, {id: id})
            end
        end
        render :nothing => true
    end

    protected
        def collection
            @favorites = end_of_association_chain.where{ team_id == my{ @team_id } }.order{ sort_order }
        end

    private
        def get_team_id!
            @team_id = Team.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

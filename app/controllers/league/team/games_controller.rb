class League::Team::GamesController < SubdomainController
    before_filter :authenticate_user!, :get_team_id!
    defaults :resource_class => Schedule, :collection_name => 'games', :instance_name => 'game'
    respond_to :json

    protected
        def collection
            @games = end_of_association_chain
                .with_opponent
                .where{ team_id == my{ @team_id }}
                .order{ week }
            @ratio = Schedule.ratio(@games)
        end

    private
        def get_team_id!
            @team_id = UserTeam.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

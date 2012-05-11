class League::Team::LineupController < InheritedResources::Base
    before_filter :authenticate_user!, :get_team_id!
    respond_to :json

    protected
        def collection
            # adds a join condition on-the-fly to avoid Activerecord sticking it in the where clause
            Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{@team_id}"
            @lineups = end_of_association_chain.joins{[ position, player_teams.outer, player_teams.player_name.outer, player_teams.position.outer, player_teams.player_contract.outer ]}
                .includes{[ position, player_teams.player_name, player_teams.position, player_teams.player_contract ]}
        end

    private
        def get_team_id!
            @team_id = Team.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

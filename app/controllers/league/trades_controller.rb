class League::TradesController < InheritedResources::Base
    before_filter :authenticate_user!, :get_team_id!
    before_filter :inject_create_params!, :only => :create

    def create
        create! do |success, failure|
            success.html{ redirect_to :back }
        end
    end

    protected
        # drops appropriate data into the request params
        def inject_create_params!
            trade_params = params[:trade]

            requested_player = PlayerTeam.find trade_params[:requested_player_id], :include => :team
            trade_params[:initial_team_id] = @team_id
            trade_params[:second_team_id] = requested_player.team_id
            trade_params[:league_id] = @team.league.id
        end

        def get_team_id!
            @team_id = Team.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

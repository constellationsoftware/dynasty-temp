class PicksController < ApplicationController
    respond_to :html, :json

    def index
    	@team = current_user.team
	end

    def update
        if @pick = Pick.find(params[:id])
            @pick.update_attributes! params[:pick]
            #render :text => ({ :balance => current_user.team.balance.to_s }).to_json
            @player_team = PlayerTeam.joins{[ lineup, lineup.position ]}
            	.includes{[ lineup, lineup.position ]}
            	.where{ (player_id == my{ @pick.player_id }) & (team_id == my{ @pick.team_id }) }
            	.first
            @pick
        end
    end
end

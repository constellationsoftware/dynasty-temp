class LineupsController < ApplicationController
    respond_to :json
    helper_method :get_player

    has_scope :with_name, :type => :boolean, :only => :roster do |controller, scope|
        scope
    end
    has_scope :with_contract, :type => :boolean, :only => :roster do |controller, scope|
        scope
    end
    has_scope :with_points, :type => :boolean, :only => :roster do |controller, scope|
        scope
    end

    def roster
        @team = current_user.team
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{@team.id}"
        @lineups = apply_scopes(Lineup)
            .joins{ player_teams.outer }
            .includes{ player_teams }
            .order{ id }
    end

    def swap
        @team = current_user.team
        from_player = PlayerTeam.find_by_team_id_and_lineup_id @team.id, params[:from]
        to_player = PlayerTeam.find_by_team_id_and_lineup_id @team.id, params[:to]
        if from_player || to_player
            from_player.update_attributes! :lineup_id => params[:to].to_i if from_player
            to_player.update_attributes! :lineup_id => params[:from].to_i if to_player
            render :json => true
        end
    end

    def get_player(player_id)
        Player.where{ id == my{ player_id } }
            .joins{[ name, contract, position, points ]}
            .includes{[ name, contract, position, points ]}
            .first
    end
end

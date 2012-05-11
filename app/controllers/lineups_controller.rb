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
            if from_player && to_player # if we need to swap player for player, this avoids unique index collisions
                from_player.lineup_id = nil
                from_player.save!
            end
            if to_player
                to_player.lineup_id = params[:from].to_i
                to_player.save!
            end
            if from_player
                from_player.lineup_id = params[:to].to_i
                from_player.save!
            end
            render :json => true
        end
    end

    def unite # Goofy verb, I know. Try to find a GOOD antonym for "reserve" if you don't like it.
        @team = current_user.team
        player = PlayerTeam.find_by_team_id_and_player_id_and_lineup_id @team.id, params[:from], nil
        if player
            player.lineup_id = params[:to]
            player.save!
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

class PlayersController < ApplicationController

    def show
        @path = @
        @player = Player.current.with_contract.with_name.with_all_points.with_points_from_season(2011).includes(:contract, :name, :position, :points, :event_points).find(params[:id])
        #REFACTOR obviously this is shit, but my brain is fried.

        if user_signed_in?
          @league = League.find(current_user.team.league_id)
          @league_players = @league.players.all

          if @league_players.include?(@player)
            @player_team = @league.player_teams.joins(:player).first
              if @player_team.team == @current_user.team
                @message = @current_user
              else
                @message = 1
                @trade_team = @player_team.team

              end
          end
          else
          @message = 0
        end


        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @player }
        end
    end

    def add
        @team = Team.find(session[:team_id])
        @player = Player.find(params[:player_id])

        ptr = PlayerTeam.new
        ptr.current = TRUE
        ptr.player_id = @player.id
        ptr.details = "Added on #{Clock.first.nice_time} by #{@team.name}"
        ptr.team_id = @team.id
        ptr.added_at = Clock.first.nice_time
        ptr.depth = 0
        ptr.position_id = @player.position.id
        ptr.waiver = 0
        ptr.league_id = @team.league_id

        ptr.save

        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You added #{@player.name.full_name}!"} }
            format.json { render json: @player }
        end
    end
end

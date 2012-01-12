class PlayersController < ApplicationController
    def show
        @team = UserTeam.find(session[:user_team_id])
        @my_league = @team.league
        @player = Player.find(params[:id])
        @person = Person.find(params[:id])
        @phase = @person.person_phases.where(:membership_type => 'teams').first
        @nfl_team = @person.teams.first
        @hometown = Location.find(@person.hometown_location_id)
        @league_ptr = @my_league.player_team_records.where(:player_id => @player.id).first
        if @league_ptr && @league_ptr.user_team
            @current_team = @league_ptr.user_team.name
        else
            @current_team = "Not signed!"
        end
        
        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @player }
        end
    end

    def add
        @team = UserTeam.find(session[:user_team_id])
        @player = Player.find(params[:player_id])

        ptr = PlayerTeamRecord.new
        ptr.current = TRUE
        ptr.player_id = @player.id
        ptr.details = "Added on #{Clock.first.nice_time} by #{@team.name}"
        ptr.user_team_id = @team.id
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

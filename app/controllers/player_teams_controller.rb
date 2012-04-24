class PlayerTeamsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html, :json
    responders :flash

    def interpolation_options
        position = @player_team.position.name
        {
            :resource_player_name => @player_team.name,
            :resource_player_position => position.downcase
        }
    end

    has_scope :with_position, :type => :boolean, :only => :league_roster do |controller, scope|
        scope.joins{ player.position }.includes{ player.position }
    end
    has_scope :with_name, :type => :boolean, :only => :league_roster do |controller, scope|
        scope.joins{ player.name }.includes{ player.name }
    end
    has_scope :with_contract, :type => :boolean, :only => :league_roster do |controller, scope|
        scope.joins{ player.contract }.includes{ player.contract }
    end
    has_scope :with_points, :type => :boolean, :only => :league_roster do |controller, scope|
        scope.joins{ player.points }.includes{ player.points }
    end


    def league_roster
        @team = current_user.team
        teams_for_league = Team.where{ league_id == my{ @team.league_id } }.select{ id }.collect{ |t| t.id }
        @player_teams = apply_scopes(PlayerTeam)
            .where{ team_id >> my{ teams_for_league } }
            .order{[ team_id, lineup_id ]}
    end

    def start
        update_and_return binding
    end

    def add
      @player = Player.find(params[:id])
      @lineup = Lineup.find(params[:lineup])


      @player_team = PlayerTeam.new
      @player_team.player_id = params[:id]
      @player_team.team_id = params[:team_id]
      @player_team.lineup_id = params[:lineup]
      @player_team.position_id = @lineup.position_id
      @player_team.depth = @lineup.string


      if @player_team.save
        redirect_to :back
      end
      redirect_to :back
    end

    def bench
        update_and_return binding
    end

    def drop
        @player_team = PlayerTeam.find(params[:id])
        @player_team.team_id = nil

        if @player_team.save
            respond_with(@player_team) do |format|
                format.html { redirect_to :back }
            end
        end
    end

    def bid
        @player_team = PlayerTeam.find(params[:id])
        @bidder = Team.find(session[:team_id])

        if @player_team.waiver_team_id.nil?
            @player_team.waiver_team_id = @bidder.id
            @player_team.save
        end

        if @player_team.waiver_team_id
            @current_winner = Team.find(@player_team.waiver_team_id)
            @current_bid = @current_winner.waiver_order
            @player_team.save
        end

        if @bidder.waiver_order < @current_bid
            @player_team.waiver_team_id = @bidder.id
            @player_team.save
        end

        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You made a bid on #{@player_team.name}"} }
            format.xml { head :ok }
        end
    end

    def resolve
        @player_team = PlayerTeam.find(params[:id])

        if @player_team.waiver_team_id.nil?
            @player_team.waiver = 0
            @player_team.save
        end

        if @player_team.waiver_team_id
            @player_team.waiver = 0
            @player_team.team_id = @player_team.waiver_team_id
            @player_team.save
        end

        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "#{Team.find(@player_team.waiver_team_id).name} won the bidding for #{@player_team.name}"} }
            format.xml { head :ok }
        end
    end
end

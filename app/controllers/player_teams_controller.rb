class PlayerTeamsController < InheritedResources::Base
    before_filter :authenticate_user!
    custom_actions :resource => [ :drop ]

    def interpolation_options
        position = @player_team.position.name
        {
            :resource_player_name => @player_team.name,
            :resource_player_position => position.downcase
        }
    end

    def start
        update_and_return binding
    end

    def bench
        update_and_return binding
    end

    def drop
        @player_team = PlayerTeam.find(params[:id])
        #@player_team.details = "Dropped by #{@player_team.team.name} on #{Clock.first.time}"
        @player_team.team_id = nil
        @player_team.depth = 0
        @player_team.waiver = 1
        @player_team.save!

        #format.html { redirect_to :back }
        render :text => '{}'
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

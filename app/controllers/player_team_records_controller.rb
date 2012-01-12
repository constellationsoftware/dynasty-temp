class PlayerTeamRecordsController < ApplicationController

    def drop
        @player_team_record = PlayerTeamRecord.find(params[:player_team_record_id])
        @player_team_record.details = "Dropped by #{@player_team_record.user_team.name} on #{Clock.first.nice_time}"
        @player_team_record.user_team_id = 0
        @player_team_record.waiver = 1

        @player_team_record.save
        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You dropped #{@player_team_record.name}! I hope his feelings arent hurt'"} }
            format.xml { head :ok }
        end
    end

    def bid
        @player_team_record = PlayerTeamRecord.find(params[:player_team_record_id])
        @bidder = UserTeam.find(session[:user_team_id])

        if @player_team_record.waiver_team_id.nil?
            @player_team_record.waiver_team_id = @bidder.id
            @player_team_record.save
        end

        if @player_team_record.waiver_team_id
            @current_winner = UserTeam.find(@player_team_record.waiver_team_id)
            @current_bid = @current_winner.waiver_order
            @player_team_record.save
        end

        if @bidder.waiver_order < @current_bid
            @player_team_record.waiver_team_id = @bidder.id
            @player_team_record.save
        end

        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You made a bid on #{@player_team_record.name}"} }
            format.xml { head :ok }
        end
    end

    def resolve
        @player_team_record = PlayerTeamRecord.find(params[:player_team_record_id])

        if @player_team_record.waiver_team_id.nil?
            @player_team_record.waiver = 0
            @player_team_record.save
        end

        if @player_team_record.waiver_team_id
            @player_team_record.waiver = 0
            @player_team_record.user_team_id = @player_team_record.waiver_team_id
            @player_team_record.save
        end

        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "#{UserTeam.find(@player_team_record.waiver_team_id).name} won the bidding for #{@player_team_record.name}"} }
            format.xml { head :ok }
        end
    end
end

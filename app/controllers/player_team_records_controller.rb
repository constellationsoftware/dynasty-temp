class PlayerTeamRecordsController < ApplicationController

  def drop
    @player_team_record = PlayerTeamRecord.find(params[:player_team_record_id])
    @player_team_record.details = "Dropped by #{@player_team_record.user_team.name} on #{Clock.first.nice_time}"
    @player_team_record.user_team_id = 0
    @player_team_record.save
    respond_to do |format|
      format.html { redirect_to :back, :flash => { :info => "You dropped #{@player_team_record.name}! I hope his feelings arent hurt'" }}
      format.xml { head :ok }
    end
  end

  def add

  end
end

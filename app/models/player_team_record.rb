class PlayerTeamRecord < ActiveRecord::Base
  set_table_name 'dynasty_team_players'
  belongs_to :player
  belongs_to :user_team

  ## TODO: Make this not suck.
  def self.match_picks
    picks = Pick.all
    picks.each do |pick|
      ptr = PlayerTeamRecord.new
      ptr.current = TRUE
      ptr.player_id = pick.player_id
      ptr.details = "Drafted in round #{pick.round}"
      ptr.user_team_id = pick.team_id
      ptr.added_at = pick.picked_at
      ptr.save
    end
  end
end

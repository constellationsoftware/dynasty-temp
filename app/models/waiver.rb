class Waiver < ActiveRecord::Base
    self.table_name = 'dynasty_waivers'
    has_many :waiver_bids
    belongs_to :player_team
    belongs_to :team

   def league
     team.league
   end





   def self.in_league(current_user_team)
     league = current_user_team.league
     teams = league.teams.pluck(:id)
     Waiver.current.where(:team_id => teams).all
   end

   def self.current
     where("end_datetime >= ?", Clock.first.time)
   end
end

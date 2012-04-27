class Waiver < ActiveRecord::Base
    self.table_name = 'dynasty_waivers'
    has_many :waiver_bids, :order => "bid_cents DESC"
    belongs_to :player_team
    belongs_to :team

   def league
     team.league
   end

   def bids
     self.waiver_bids
   end

  def resolve
    self.waiver_bids.collect
  end

   def current_user_bids(current_user)
     self.bids.where(:team_id => current_user.team.id)
   end

   def self.in_league(current_user_team)
     league = current_user_team.league
     teams = league.teams.pluck(:id)
     Waiver.current.where(:team_id => teams).all
   end

   def self.current
     where("end_datetime > ?", Clock.first.time)
   end

  def self.resolved_now
    where("end_datetime = ?", Clock.first.time)
  end
end

# == Schema Information
#
# Table name: dynasty_player_points
#
#  id                   :integer(4)      not null, primary key
#  points               :integer(4)      not null
#  player_id            :integer(4)      not null
#  created_at           :datetime
#  updated_at           :datetime
#  year                 :integer(4)      default(2000), not null
#  defensive_points     :integer(4)      default(0), not null
#  fumbles_points       :integer(4)      default(0), not null
#  passing_points       :integer(4)      default(0), not null
#  rushing_points       :integer(4)      default(0), not null
#  sacks_against_points :integer(4)      default(0), not null
#  scoring_points       :integer(4)      default(0), not null
#  special_teams_points :integer(4)      default(0), not null
#  games_played         :integer(4)      default(0), not null
#

class PersonScore < ActiveRecord::Base
    self.table_name = 'dynasty_player_points'

    belongs_to :person
    belongs_to :draftable_player, :primary_key => "person_id"
end

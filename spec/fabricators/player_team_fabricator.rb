# == Schema Information
#
# Table name: dynasty_player_teams
#
#  id             :integer(4)      not null, primary key
#  player_id      :integer(4)
#  team_id        :integer(4)
#  current        :boolean(1)
#  added_at       :datetime
#  removed_at     :datetime
#  details        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  position_id    :integer(4)
#  depth          :integer(4)      default(0), not null
#  waiver         :boolean(1)
#  waiver_team_id :integer(4)
#  league_id      :integer(4)
#  lineup_id      :integer(4)
#

Fabricator :player_team do
    current     1
    player!
    team!
    lineup!
end

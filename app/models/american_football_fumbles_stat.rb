# == Schema Information
#
# Table name: american_football_fumbles_stats
#
#  id                                    :integer(4)      not null, primary key
#  fumbles_committed                     :string(100)
#  fumbles_forced                        :string(100)
#  fumbles_recovered                     :string(100)
#  fumbles_lost                          :string(100)
#  fumbles_yards_gained                  :string(100)
#  fumbles_own_committed                 :string(100)
#  fumbles_own_recovered                 :string(100)
#  fumbles_own_lost                      :string(100)
#  fumbles_own_yards_gained              :string(100)
#  fumbles_opposing_committed            :string(100)
#  fumbles_opposing_recovered            :string(100)
#  fumbles_opposing_lost                 :string(100)
#  fumbles_opposing_yards_gained         :string(100)
#  fumbles_own_touchdowns                :integer(4)
#  fumbles_opposing_touchdowns           :integer(4)
#  fumbles_committed_defense             :integer(4)
#  fumbles_committed_special_teams       :integer(4)
#  fumbles_committed_other               :integer(4)
#  fumbles_lost_defense                  :integer(4)
#  fumbles_lost_special_teams            :integer(4)
#  fumbles_lost_other                    :integer(4)
#  fumbles_forced_defense                :integer(4)
#  fumbles_recovered_defense             :integer(4)
#  fumbles_recovered_special_teams       :integer(4)
#  fumbles_recovered_other               :integer(4)
#  fumbles_recovered_yards_defense       :integer(4)
#  fumbles_recovered_yards_special_teams :integer(4)
#  fumbles_recovered_yards_other         :integer(4)
#

class AmericanFootballFumblesStat < BaseStat
    self.table_name = "american_football_fumbles_stats"
    # TODO: Check scoring vs. spreadsheets

    def points
        (fumbles_committed.to_f * 2).to_i
    end
end

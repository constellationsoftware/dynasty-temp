# == Schema Information
#
# Table name: american_football_scoring_stats
#
#  id                             :integer(4)      not null, primary key
#  touchdowns_total               :string(100)
#  touchdowns_passing             :string(100)
#  touchdowns_rushing             :string(100)
#  touchdowns_special_teams       :string(100)
#  touchdowns_defensive           :string(100)
#  extra_points_attempts          :string(100)
#  extra_points_made              :string(100)
#  extra_points_missed            :string(100)
#  extra_points_blocked           :string(100)
#  field_goal_attempts            :string(100)
#  field_goals_made               :string(100)
#  field_goals_missed             :string(100)
#  field_goals_blocked            :string(100)
#  safeties_against               :string(100)
#  two_point_conversions_attempts :string(100)
#  two_point_conversions_made     :string(100)
#  touchbacks_total               :string(100)
#  safeties_against_opponent      :integer(4)
#

class AmericanFootballScoringStat < BaseStat
    self.table_name = "american_football_scoring_stats"
    # TODO: Check scoring vs. spreadsheets

    def points
        return (extra_points_made.to_f +
            (field_goals_made.to_f * 3)).to_i
    end
end

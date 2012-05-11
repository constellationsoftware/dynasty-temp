# == Schema Information
#
# Table name: american_football_special_teams_stats
#
#  id                                    :integer(4)      not null, primary key
#  returns_punt_total                    :string(100)
#  returns_punt_yards                    :string(100)
#  returns_punt_average                  :string(100)
#  returns_punt_longest                  :string(100)
#  returns_punt_touchdown                :string(100)
#  returns_kickoff_total                 :string(100)
#  returns_kickoff_yards                 :string(100)
#  returns_kickoff_average               :string(100)
#  returns_kickoff_longest               :string(100)
#  returns_kickoff_touchdown             :string(100)
#  returns_total                         :string(100)
#  returns_yards                         :string(100)
#  punts_total                           :string(100)
#  punts_yards_gross                     :string(100)
#  punts_yards_net                       :string(100)
#  punts_longest                         :string(100)
#  punts_inside_20                       :string(100)
#  punts_inside_20_percentage            :string(100)
#  punts_average                         :string(100)
#  punts_blocked                         :string(100)
#  touchbacks_total                      :string(100)
#  touchbacks_total_percentage           :string(100)
#  touchbacks_kickoffs                   :string(100)
#  touchbacks_kickoffs_percentage        :string(100)
#  touchbacks_punts                      :string(100)
#  touchbacks_punts_percentage           :string(100)
#  touchbacks_interceptions              :string(100)
#  touchbacks_interceptions_percentage   :string(100)
#  fair_catches                          :string(100)
#  punts_against_blocked                 :integer(4)
#  field_goals_against_attempts_1_to_19  :integer(4)
#  field_goals_against_made_1_to_19      :integer(4)
#  field_goals_against_attempts_20_to_29 :integer(4)
#  field_goals_against_made_20_to_29     :integer(4)
#  field_goals_against_attempts_30_to_39 :integer(4)
#  field_goals_against_made_30_to_39     :integer(4)
#  field_goals_against_attempts_40_to_49 :integer(4)
#  field_goals_against_made_40_to_49     :integer(4)
#  field_goals_against_attempts_50_plus  :integer(4)
#  field_goals_against_made_50_plus      :integer(4)
#  field_goals_against_attempts          :integer(4)
#  extra_points_against_attempts         :integer(4)
#  tackles                               :integer(4)
#  tackles_assists                       :integer(4)
#

class AmericanFootballSpecialTeamsStat < BaseStat
    # TODO: Figure out how to score and apply field goal attempts based on distance

    self.table_name = "american_football_special_teams_stats"

    def points
        0
    end
end

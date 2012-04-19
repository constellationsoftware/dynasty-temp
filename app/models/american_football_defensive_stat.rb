# == Schema Information
#
# Table name: american_football_defensive_stats
#
#  id                                             :integer(4)      not null, primary key
#  tackles_total                                  :string(100)
#  tackles_solo                                   :string(100)
#  tackles_assists                                :string(100)
#  interceptions_total                            :string(100)
#  interceptions_yards                            :string(100)
#  interceptions_average                          :string(100)
#  interceptions_longest                          :string(100)
#  interceptions_touchdown                        :string(100)
#  quarterback_hurries                            :string(100)
#  sacks_total                                    :string(100)
#  sacks_yards                                    :string(100)
#  passes_defensed                                :string(100)
#  first_downs_against_total                      :integer(4)
#  first_downs_against_rushing                    :integer(4)
#  first_downs_against_passing                    :integer(4)
#  first_downs_against_penalty                    :integer(4)
#  conversions_third_down_against                 :integer(4)
#  conversions_third_down_against_attempts        :integer(4)
#  conversions_third_down_against_percentage      :decimal(5, 2)
#  conversions_fourth_down_against                :integer(4)
#  conversions_fourth_down_against_attempts       :integer(4)
#  conversions_fourth_down_against_percentage     :decimal(5, 2)
#  two_point_conversions_against                  :integer(4)
#  two_point_conversions_against_attempts         :integer(4)
#  offensive_plays_against_touchdown              :integer(4)
#  offensive_plays_against_average_yards_per_game :decimal(5, 2)
#  rushes_against_attempts                        :integer(4)
#  rushes_against_yards                           :integer(4)
#  rushing_against_average_yards_per_game         :decimal(5, 2)
#  rushes_against_touchdowns                      :integer(4)
#  rushes_against_average_yards_per               :decimal(5, 2)
#  rushes_against_longest                         :integer(4)
#  receptions_against_total                       :integer(4)
#  receptions_against_yards                       :integer(4)
#  receptions_against_touchdowns                  :integer(4)
#  receptions_against_average_yards_per           :decimal(5, 2)
#  receptions_against_longest                     :integer(4)
#  passes_against_yards_net                       :integer(4)
#  passes_against_yards_gross                     :integer(4)
#  passes_against_attempts                        :integer(4)
#  passes_against_completions                     :integer(4)
#  passes_against_percentage                      :decimal(5, 2)
#  passes_against_average_yards_per_game          :decimal(5, 2)
#  passes_against_average_yards_per               :decimal(5, 2)
#  passes_against_touchdowns                      :integer(4)
#  passes_against_touchdowns_percentage           :decimal(5, 2)
#  passes_against_longest                         :integer(4)
#  passes_against_rating                          :decimal(5, 2)
#  interceptions_percentage                       :decimal(5, 2)
#  defense_rank                                   :integer(4)
#  defense_rank_pass                              :integer(4)
#  defense_rank_rush                              :integer(4)
#  turnovers_takeaway                             :integer(4)
#

class AmericanFootballDefensiveStat < BaseStat
    self.table_name = "american_football_defensive_stats"


    def points
        return tackles_solo.to_i + ((interceptions_total.to_i + sacks_total.to_i) * 3)

    end

end

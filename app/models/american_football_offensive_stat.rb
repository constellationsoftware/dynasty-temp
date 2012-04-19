# == Schema Information
#
# Table name: american_football_offensive_stats
#
#  id                                :integer(4)      not null, primary key
#  offensive_plays_yards             :string(100)
#  offensive_plays_number            :string(100)
#  offensive_plays_average_yards_per :string(100)
#  possession_duration               :string(100)
#  turnovers_giveaway                :string(100)
#  tackles                           :integer(4)
#  tackles_assists                   :integer(4)
#  offensive_rank                    :integer(4)
#

class AmericanFootballOffensiveStat < BaseStat
    # TODO: Check scoring vs. spreadsheets

    self.table_name = "american_football_offensive_stats"
end

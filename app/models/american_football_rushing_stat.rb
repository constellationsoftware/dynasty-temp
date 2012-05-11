# == Schema Information
#
# Table name: american_football_rushing_stats
#
#  id                        :integer(4)      not null, primary key
#  rushes_attempts           :string(100)
#  rushes_yards              :string(100)
#  rushes_touchdowns         :string(100)
#  rushing_average_yards_per :string(100)
#  rushes_first_down         :string(100)
#  rushes_longest            :string(100)
#  rushing_rank              :integer(4)
#

class AmericanFootballRushingStat < BaseStat
    self.table_name = "american_football_rushing_stats"
    # TODO: Check scoring vs. spreadsheets

    def points
        return ((rushes_yards.to_f / 10) +
            (rushes_touchdowns.to_f * 6)).to_i
    end
end

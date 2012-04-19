# == Schema Information
#
# Table name: american_football_sacks_against_stats
#
#  id                  :integer(4)      not null, primary key
#  sacks_against_yards :string(100)
#  sacks_against_total :string(100)
#

class AmericanFootballSacksAgainstStat < BaseStat
    self.table_name = "american_football_sacks_against_stats"

    def points
        return (sacks_against_total.to_i * -1)
    end
end

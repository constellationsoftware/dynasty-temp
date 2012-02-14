class AmericanFootballSacksAgainstStat < BaseStat
    self.table_name "american_football_sacks_against_stats"

    def points
        return (sacks_against_total.to_i * -1)
    end
end

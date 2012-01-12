class AmericanFootballPassingStat < BaseStat
    set_table_name "american_football_passing_stats"
    # TODO: Check scoring vs. spreadsheets

    has_many :stats,
             :foreign_key => 'stat_repository_id',
             :conditions => ['stat_repository_type = ?', 'american_football_passing_stats']

    def points
        return ((passes_touchdowns.to_f * 6) +
            (passes_yards_net.to_f / 25) +
            (receptions_touchdowns.to_f * 6) +
            (receptions_yards.to_f / 10)).to_i
    end
end

class AmericanFootballPassingStat < BaseStat
  set_table_name "american_football_passing_stats"
  # TODO: Check scoring vs. spreadsheets
  

  def score_modifier

    return ((passes_touchdowns.to_f * 6) +
            (passes_yards_net.to_f / 25) +
            (receptions_touchdowns.to_f * 6) +
            (receptions_yards.to_f / 10))

  end
end

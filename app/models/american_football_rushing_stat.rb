class AmericanFootballRushingStat < BaseStat
  set_table_name "american_football_rushing_stats"
  # TODO: Check scoring vs. spreadsheets
 
  def points
    return ((rushes_yards.to_f / 10) +
            (rushes_touchdowns.to_f * 6)).to_i
  end
end

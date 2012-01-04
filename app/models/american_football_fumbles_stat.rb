class AmericanFootballFumblesStat < BaseStat
  set_table_name "american_football_fumbles_stats"
  # TODO: Check scoring vs. spreadsheets

  def points
    (fumbles_committed.to_f * 2).to_i
  end
end

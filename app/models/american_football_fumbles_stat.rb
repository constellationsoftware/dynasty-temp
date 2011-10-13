class AmericanFootballFumblesStat < BaseStat
  set_table_name "american_football_fumbles_stats"
  # TODO: Check scoring vs. spreadsheets

  def score_modifier
    return fumbles_committed.to_f * 2
  end
end

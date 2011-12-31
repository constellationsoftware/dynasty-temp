class AmericanFootballScoringStat < BaseStat
  set_table_name "american_football_scoring_stats"
  # TODO: Check scoring vs. spreadsheets
  
  def points
    return (extra_points_made.to_f +
            (field_goals_made.to_f * 3))
  end
end

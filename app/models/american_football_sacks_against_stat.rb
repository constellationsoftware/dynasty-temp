class AmericanFootballSacksAgainstStat < BaseStat
  set_table_name "american_football_sacks_against_stats"

  def score_modifier
    return sacks_against_total.to_f
  end
end

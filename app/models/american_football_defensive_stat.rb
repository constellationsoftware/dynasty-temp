class AmericanFootballDefensiveStat < BaseStat
  set_table_name "american_football_defensive_stats"


    def points
      return tackles_solo.to_i + (( interceptions_total.to_i + sacks_total.to_i ) * 3)

    end

end

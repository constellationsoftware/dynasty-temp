# == Schema Information
#
# Table name: american_football_penalties_stats
#
#  id                  :integer(4)      not null, primary key
#  penalties_total     :string(100)
#  penalty_yards       :string(100)
#  penalty_first_downs :string(100)
#

class AmericanFootballPenaltiesStat < BaseStat
    self.table_name = "american_football_penalties_stats"
    # TODO: Apply scoring penalty?

end

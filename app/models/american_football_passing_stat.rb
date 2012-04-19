# == Schema Information
#
# Table name: american_football_passing_stats
#
#  id                              :integer(4)      not null, primary key
#  passes_attempts                 :string(100)
#  passes_completions              :string(100)
#  passes_percentage               :string(100)
#  passes_yards_gross              :string(100)
#  passes_yards_net                :string(100)
#  passes_yards_lost               :string(100)
#  passes_touchdowns               :string(100)
#  passes_touchdowns_percentage    :string(100)
#  passes_interceptions            :string(100)
#  passes_interceptions_percentage :string(100)
#  passes_longest                  :string(100)
#  passes_average_yards_per        :string(100)
#  passer_rating                   :string(100)
#  receptions_total                :string(100)
#  receptions_yards                :string(100)
#  receptions_touchdowns           :string(100)
#  receptions_first_down           :string(100)
#  receptions_longest              :string(100)
#  receptions_average_yards_per    :string(100)
#  passing_rank                    :integer(4)
#

class AmericanFootballPassingStat < BaseStat
    self.table_name = "american_football_passing_stats"
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

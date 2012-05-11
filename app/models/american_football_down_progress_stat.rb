# == Schema Information
#
# Table name: american_football_down_progress_stats
#
#  id                                 :integer(4)      not null, primary key
#  first_downs_total                  :string(100)
#  first_downs_pass                   :string(100)
#  first_downs_run                    :string(100)
#  first_downs_penalty                :string(100)
#  conversions_third_down             :string(100)
#  conversions_third_down_attempts    :string(100)
#  conversions_third_down_percentage  :string(100)
#  conversions_fourth_down            :string(100)
#  conversions_fourth_down_attempts   :string(100)
#  conversions_fourth_down_percentage :string(100)
#

class AmericanFootballDownProgressStat < BaseStat
    self.table_name = "american_football_down_progress_stats"
end

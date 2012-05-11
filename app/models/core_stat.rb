# == Schema Information
#
# Table name: core_stats
#
#  id                        :integer(4)      not null, primary key
#  score                     :string(100)
#  score_opposing            :string(100)
#  score_attempts            :string(100)
#  score_attempts_opposing   :string(100)
#  score_percentage          :string(100)
#  score_percentage_opposing :string(100)
#  time_played_event         :string(40)
#  time_played_total         :string(40)
#  time_played_event_average :string(40)
#  events_played             :string(40)
#  events_started            :string(40)
#  position_id               :integer(4)
#  series_score              :integer(4)
#  series_score_opposing     :integer(4)
#

class CoreStat < BaseStat
    self.table_name = "core_stats"
    belongs_to :position

    def points
        0
    end

end

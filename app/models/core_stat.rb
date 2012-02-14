class CoreStat < BaseStat
    self.table_name = "core_stats"
    belongs_to :position

    def points
        0
    end

end

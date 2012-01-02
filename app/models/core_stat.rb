class CoreStat < BaseStat
  set_table_name "core_stats"
  belongs_to :position

  def points
    0
  end

end

class Player < ActiveRecord::Base
  set_table_name 'persons'
  POSITION_PRIORITIES = ['QB', 'WR', 'RB', 'TE', 'C', 'G', 'T', 'K']
  POSITION_QUANTITIES = {
    :qb => 1,
    :wr => 2,
    :rb => 2,
    :te => 1,
    :k => 1,
    :t => 2,
    :g => 2,
    :c => 1
  }
  POSITION_FILLED_WEIGHT = 3
  
  has_one :name,
    :class_name => 'DisplayName',
    :foreign_key => 'entity_id',
    :conditions => [ 'entity_type = ?', 'persons' ]
  has_one  :score, :class_name => 'PersonScore'
  has_one  :position_link, :class_name => 'PlayerPosition'
  has_one  :position, :through => :position_link
  has_many :teams, :class_name => 'UserTeam'
  has_many :leagues, :through => :teams
  has_many :picks
  has_one  :points, :class_name => 'PlayerPoint'
  has_one  :contract, :foreign_key => 'person_id'

  # Returns a case statement for ordering by a particular set of strings
  # Note that the SQL is built by hand and therefore injection is possible,
  # however since we're declaring the priorities in a constant above it's
  # safe.
  def self.order_by_position_priority
    ret = "CASE"
    POSITION_PRIORITIES.each_with_index do |p, i|
      ret << " WHEN SUBSTRING(dynasty_positions.abbreviation, 1, 2) = '#{p}' THEN #{i}"
    end
    ret << " END ASC"
  end

  #
  # SCOPES
  #
  default_scope joins{name}
  scope :roster, lambda { |my_user|
    joins{picks.user}
      .where{picks.user.id.eq my_user.id}
  }
  scope :by_rating, lambda {
    current_year = Season.order{season_key.desc}.first.season_key

    joins{points}
    .where{points.year == "#{current_year}"}
    .order{points.points.desc}
  }
  scope :available, joins{picks.outer}.where{isnull(picks.id)}
  scope :by_position, Proc.new { |filter = nil|
    if !(filter.nil?) and filter.size > 0
      filter = filter[0] # for now we're not supporting multiple filters
      joins{position}
        .where{position.abbreviation == my{filter['value'].to_s}}
    end
  }
  scope :by_position_priority, joins{position}
    .where{substring(position.abbreviation, 1, 2) >> my{POSITION_PRIORITIES}}
    .order(order_by_position_priority)
  scope :weighted, lambda { |team|
    # find how many picks have been made by position
    position_counts = Position.find_by_sql("
      SELECT abbreviation AS abbr, (
        SELECT COUNT(*)
        FROM dynasty_draft_picks dp
        JOIN dynasty_player_positions pp
        ON dp.player_id = pp.player_id
        WHERE team_id = #{team.id} AND pp.position_id = pos.id
      ) AS count
      FROM dynasty_positions pos
    ")

    # filter out the position counts less than the max position quantities
    filled_pos = position_counts.delete_if { |position_count|
      max = POSITION_QUANTITIES[position_count.abbr.to_sym]
      position_count.count == 0 or (!(max.nil?) and max >= position_count.count)
    }.collect{ |x| x.abbr }
    weighted_point_calc = "IF(dynasty_positions.abbreviation IN ('#{filled_pos.join('\', \'')}'), points / #{POSITION_FILLED_WEIGHT}, points)"

    current_year = Season.order{season_key.desc}.first.season_key
    joins{[name, points, position]}
      .where{points.year == "#{current_year}"}
      .select("#{table_name}.*, #{weighted_point_calc} AS weighted_points")
  }
end

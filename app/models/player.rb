class Player < ActiveRecord::Base
  set_table_name 'persons'
  POSITION_PRIORITIES = ['QB', 'WR', 'RB', 'TE', 'K']
  POSITION_QUANTITIES = {
    :qb => 2,
    :wr => 4,
    :rb => 4,
    :te => 2,
    :k => 2,
    :t => 4,
    :g => 4,
    :c => 2
  }
  
  has_one :name,
    :class_name => 'DisplayName',
    :foreign_key => 'entity_id',
    :conditions => [ 'entity_type = ?', 'persons' ]
  accepts_nested_attributes_for :name
  has_one  :score, :class_name => 'PersonScore'
  has_one  :position_link, :class_name => 'PlayerPosition'
  has_one  :position, :through => :position_link
  has_many :teams, :class_name => 'UserTeam'
  has_many :leagues, :through => :teams
  has_many :picks
  has_one  :points, :class_name => 'PlayerPoint'
  has_one  :contract, :foreign_key => 'person_id'
  accepts_nested_attributes_for :points

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

  default_scope joins{name}
  scope :roster, lambda { |my_user|
    joins{picks.user}
      .where{picks.user.id.eq my_user.id}
  }
  scope :by_rating, joins{points}.order{points.points.desc}
  scope :available, joins{picks.outer}.where{isnull(picks.id)}

  # scopes
  scope :by_position, Proc.new { |filter = nil|
    if !(filter.nil?) and filter.size > 0
      filter = filter[0] # for now we're not supporting multiple filters
      joins{position}
        .where{position.abbreviation == my{filter['value'].to_s}}
    else
      joins{position}
        .where{substring(position.abbreviation, 1, 2) >> my{POSITION_PRIORITIES}}
        .order(order_by_position_priority)
    end
  }
end

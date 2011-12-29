class Position < AbstractPlayerData
  has_many :person_phases, :foreign_key => "regular_position_id"
  belongs_to :affiliation
  belongs_to :group, :class_name => 'PositionGroup', :foreign_key => 'position_group_id'

  default_scope includes{group}

  def name
    return self.group.name
  end

=begin
  def self.quarterback
    Position.where(:name => 'Quarterback').map(&:id)
  end

  def self.runningback
    Position.where(:name => 'Running Back').map(&:id)
  end

  def self.widereceiver
    Position.where(:name => 'Wide Receiver').map(&:id)
  end

  def self.tightend
    Position.where(:name => 'Tight End').map(&:id)
  end
=end
end

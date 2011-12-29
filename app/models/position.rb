class Position < AbstractPlayerData
  has_many :person_phases, :foreign_key => "regular_position_id"
  belongs_to :affiliation
  belongs_to :group, :class_name => 'PositionGroup', :foreign_key => 'position_group_id'

  default_scope includes{group}

  def name
    return self.group.name
  end
end

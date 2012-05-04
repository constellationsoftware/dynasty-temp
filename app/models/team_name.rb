class TeamName < DisplayName
    belongs_to :team, :class_name => 'SportsDb::Team', :foreign_key => 'entity_id', :inverse_of => :name
end

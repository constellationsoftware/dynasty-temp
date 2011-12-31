class Player < ActiveRecord::Base
  set_table_name 'persons'
  after_initialize do
    @full_name = self.name.full_name
  end
  
  has_one :name,
    :class_name => 'DisplayName',
    :foreign_key => 'entity_id',
    :conditions => [ 'entity_type = ?', 'persons' ]
  has_one  :score, :class_name => 'PersonScore'
  has_one  :position
  has_many :teams, :class_name => 'UserTeam'
  has_many :leagues, :through => :teams

  default_scope joins{name}
end

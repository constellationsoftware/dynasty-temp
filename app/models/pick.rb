class Pick < ActiveRecord::Base
  set_table_name 'dynasty_draft_picks'
  
  belongs_to :team, :class_name => 'UserTeam'
  has_one :user, :through => :team
  belongs_to :player, :class_name => 'Person'
  belongs_to :draft, :inverse_of => :picks
  belongs_to :player_position,
    :class_name => 'PlayerPosition',
    :foreign_key => 'player_id',
    :primary_key => 'player_id'

  default_scope :order => 'pick_order ASC'
end

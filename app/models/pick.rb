class Pick < ActiveRecord::Base
  set_table_name 'dynasty_draft_picks'
  
  belongs_to :team, :class_name => 'UserTeam'
  has_one :user, :through => :team
  belongs_to :player
  belongs_to :draft, :inverse_of => :picks

  default_scope :order => 'pick_order ASC'
end

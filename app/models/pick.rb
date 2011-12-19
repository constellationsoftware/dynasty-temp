class Pick < ActiveRecord::Base
  belongs_to :team, :class_name => 'UserTeam'
  has_one :user, :through => :team
  belongs_to :player, :class_name => 'Salary', :foreign_key => 'person_id'
  belongs_to :draft, :inverse_of => :picks

  default_scope :order => 'pick_order ASC'
  scope :draft_data, includes(:user, :team).order('pick_order ASC')
end

class Player < ActiveRecord::Base
  belongs_to :team, :class_name => 'UserTeam'
  has_one :user, :through => :team
  belongs_to :player, :class_name => 'Person', :foreign_key => 'person_id'
end

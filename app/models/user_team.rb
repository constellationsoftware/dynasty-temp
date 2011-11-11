class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :players

  scope :online, self.where(:is_online => true)
  scope :offline, self.where(:is_online => false)

  def is_offline
  	self.offline
  end

 # requires :association, :user, :league
 # requires :attribute, :name
end

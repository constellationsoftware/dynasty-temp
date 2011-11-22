class League < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug

  #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
  has_many :teams, :class_name => 'UserTeam'
  has_many :users, :through => :user_teams
  has_many :drafts
#  requires :attribute, :name, :size
  belongs_to :manager, :class_name => 'User', :inverse_of => :leagues

  # gets the active draft (if any)
  def draft
    self.drafts.first
  end
end

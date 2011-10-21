class League < ActiveRecord::Base
  #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
  has_many :user_teams
  has_many :users, :through => :user_teams
  has_many :drafts
#  requires :attribute, :name, :size
end

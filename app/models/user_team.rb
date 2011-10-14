class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :picks

  has_many :user_team_persons
  has_many :persons, :through => :user_team_persons

 # requires :association, :user, :league
 # requires :attribute, :name
end

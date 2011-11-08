class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :players

 # requires :association, :user, :league
 # requires :attribute, :name
end

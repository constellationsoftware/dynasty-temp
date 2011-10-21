class UserTeamPerson < ActiveRecord::Base
  belongs_to :user_team
  belongs_to :person

#  requires :association, :user_team, :person
end

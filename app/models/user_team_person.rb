class UserTeamPerson < ActiveRecord::Base
	set_table_name "user_team_persons"
  belongs_to :user_team
  belongs_to :person

#  requires :association, :user_team, :person
end

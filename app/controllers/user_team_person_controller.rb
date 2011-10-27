class UserTeamPersonController < ApplicationController

	def index
    @user_team_person = UserTeamPerson.all


    respond_to do |format|
      format.html # index.html.erb

      format.json { render json: { :results => @user_team_person }}
    end
  end
end

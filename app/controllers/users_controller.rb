class UsersController < InheritedResources::Base
  before_filter :authenticate_user!

  def home
    @current_user = current_user
    @current_user_teams = current_user.teams
    if @current_user_teams.blank?
      @welcome_message = "You have no teams right now. Please contact a beta administrator for access to a testing league."
    end
  end
end

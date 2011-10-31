class ApiController < ApplicationController
  #before_filter :authenticate_user!

  def post_message
  end

  def auth
    #if current_user
      #Rails.logger.info current_user.inspect
      #Rails.logger.info request.session_options[:id]
      #user = current_user
      auth = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => { # => optional - for example
          :team_name => current_user.user_team.name,
          :email => current_user.email,
          :league => current_user.user_team.league_id
        }
      })
      render :json => auth
    #else
     # render :text => "Not authorized", :status => '403'
  end
end

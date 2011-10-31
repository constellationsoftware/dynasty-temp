class ApiController < ApplicationController
  #before_filter :authenticate_user!

  def post_message
    chat = 'presence-test'
    message = params[:message]
    payload = { :user => current_user.email, :message => message }
    Rails.logger.info payload.inspect
    Pusher[chat].trigger('send_message', payload)
    render :text => "sent"
  end

  def auth
    #Rails.logger.info current_user.inspect
    auth = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      :user_id => current_user.id, # => required
      :user_info => { # => optional - for example
        :team_name => current_user.user_team.name,
        :email => current_user.email,
        :league => current_user.user_team.league_id
      }
    })
    render :json => auth
  end
end

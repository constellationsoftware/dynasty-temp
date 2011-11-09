class ApiController < ApplicationController
  #before_filter :authenticate_user!
  #protect_from_forgery :except => :auth # stop rails CSRF protection for this action

  def pick
    player = Salary.find(params[:player_id])


    payload = {
      :user_id => current_user[:id],
      :user_name => current_user[:name],
      :player => player
    }
    Pusher['presence-draft'].trigger_async('draft:pick:received', payload, params[:socket_id])

    # "simulate" a pick being made by another player for Peyton Manning
    #peyt = Salary.find(3)
    #test = {
    #  :user_id => 0,
    #  :user_name => 'Broto Baggins',
    #  :player => peyt
    #}
    #Pusher['presence-draft'].trigger_async('draft:pick:received', test)

    # figure out the next user in the draft
    # hardcode this for now
    #next_user_id =  current_user[:id]
    #  when 2 then 2
    #  else 2
    #end
    #event_name = 'draft:pick:user_' + next_user_id.to_s
    #Pusher['presence-draft'].trigger_async(event_name, payload)
    render :text => "sent"
  end

  def post_message
    payload = {
      :user => current_user.email,
      :message => params[:message]
    }
    Rails.logger.info payload.inspect
    Pusher[params[:channel_name]].trigger_async('draft:', payload, params[:socket_id])
    render :text => "sent"
  end

  def ready
    payload = { :user_id => current_user.id }
    # TODO: unhack this whole thing
    if current_user[:id].to_i === params[:id].to_i and current_user[:id].to_i === 2
      #start the picking process
      event_name = 'draft:pick:user_' + current_user[:id].to_s
      Pusher['presence-draft'].trigger_async(event_name, payload)
    end
    render :json => "sent"
  end

  def auth
    @user = User.find(current_user.id)
    payload = {
      :user_id => current_user.id,
      :user_info => { # => optional - for example
        :name => @user.name,
        :email => @user.email
        #:league => current_user.team.league_id

      }
    }

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], payload)
    render :json => response
  end


  protected
    # wraps pusher's 'trigger' method so we can automatically append the
    # socket id if available
    def trigger(channel, event, payload)
      Rails.logger.info channel
      Rails.logger.info event
      Rails.logger.info payload

      socket_id = payload.delete('socket_id')
      return Pusher[channel].trigger_async(event, payload, socket_id)
    end 
end

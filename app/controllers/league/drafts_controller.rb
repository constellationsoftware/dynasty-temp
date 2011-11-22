class League::DraftsController < SubdomainController
  layout 'drafts'
  before_filter :authenticate_user!
  before_filter :get_team!, :except => [:edit, :update, :destroy]

  singleton_belongs_to :league
  custom_actions :resource => [:start, :reset, :pick]

  # starts the draft
  def start
    start! do |format|
      if !(@draft.status === :finished)
        puts @draft.inspect
        @draft.start
        # trigger the pick request for the user for the current_pick
        pick_user_id = @draft.current_pick.team.uuid
        Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:start-' + pick_user_id, {})
        format.text { render :text => "Starting draft for #{@league.name}" }  
    else
        raise 'A finished draft must be reset before it can be started.'
      end
    end
  end

=begin
  def halt
    puts @draft.status
    if @draft.status === :started
      @draft.status = :paused
      @draft.save()

      payload = {
        :user_id => current_user.id,
        :user_info => {
          :name => current_user.name
        }
      }
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pause', payload)
      render :text => 'success'
    else
      render :text => 'failed'
    end
  end

  def resume
    if @draft.status === :paused
      @draft.status = :started
      @draft.save()

      # trigger the pick request for the user for the current_pick
      pick_user_id = @draft.current_pick.team.uuid
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:resume-' + pick_user_id, {})

      payload = {
        :user_id => current_user.id,
        :user_info => {
          :name => current_user.name
        }
      }
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:resume', payload, params[:socket_id])
      render :text => 'success'
    else
      render :text => 'failed'
    end
  end
=end

  def reset
    reset! do |format|
      @draft.reset
      payload = {
        :user_id => current_user.id,
        :user_info => {
          :name => current_user.name
        }
      }
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:reset', payload)
      
      format.text { render :text => "Resetting draft for #{@league.name}" }  
    end
  end

  # commits a pick made from the frontend
  def pick
    pick! do |format|
      player = Salary.find(params[:player_id])

      # make sure the user making the pick is "up" and if player is found
      if @draft.current_pick.user === current_user and player
        pick = @draft.make_pick(player)

        # notify clients of the pick
        payload = { :player_id => pick.player.id, :user_id => pick.user.id }
        Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:update', payload, params[:socket_id])

        # advance the draft
        @draft.advance

        if !(@draft.status === :finished)
          puts 'triggering start event for ' + @draft.current_pick.team.name + '(' + @draft.current_pick.team.uuid + ')'
          puts Draft::CHANNEL_PREFIX + @draft.league.slug
          # trigger the pick request for the user for the current_pick
          pick_user_id = @draft.current_pick.team.uuid
          Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:start-' + pick_user_id, {})
        end

        format.text { render :text => "#{pick.user.name} picked #{pick.player.full_name}" }  
      else
        raise 'Request parameters invalid.'
      end
    end
  end

  def dispatch_push_event(channel, event_name, payload = {}, socket_id = nil)
    puts event_name, payload, socket_id
    Pusher[channel].trigger(event_name, payload, socket_id)
  end

  def auth
    payload = {
      :user_id => current_user.id,
      :user_info => {
        :team_id => @team.uuid
      }
    }

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], payload)
    render :json => response
  end

  private
    def get_team!
      @team = UserTeam.where{(league = @league) & (user = @current_user)}.first
    end
end

class League::DraftsController < SubdomainController
  layout 'drafts'

  before_filter :authenticate_user!
  before_filter :get_team!

  def get_team!
    @team = UserTeam.where(:league, @league).where(:user, @current_user)
  end

  respond_to :html, :only => :show
  respond_to :json, :only => :auth

  belongs_to :league, :singleton => true

  def show
    show! do
      puts @team.to_json
    end
  end

  # starts the draft
  def start
    @draft = self.resource

    # check to see if there are any participants online
    if @draft.online.size > 0
      @draft.start

      if !@draft.finished
        # trigger the pick request for the user for the current_pick
        pick_user_id = @draft.current_pick.team.uuid
        Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:start-' + pick_user_id, {})
      end

      render :text => 'Draft started!'
    else
      render :text => 'Could not start draft because no one was online!'
    end
  end

  # commits a pick made from the frontend
  def pick
    @draft = self.resource
    team = @draft.teams.first
    player = Salary.find(params[:player_id])

    # make sure the user making the pick is "up" and if player is found
    if @draft.current_pick.user === current_user and player
      pick = @draft.make_pick(player)

      # notify clients of the pick
      payload = { :player_id => pick.player.id, :user_id => pick.user.id }
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:update', payload, params[:socket_id])

      # advance the draft
      @draft.advance

      if !@draft.finished
        puts 'triggering start event for ' + @draft.current_pick.team.name + '(' + @draft.current_pick.team.uuid + ')'
        puts Draft::CHANNEL_PREFIX + @draft.league.slug
        # trigger the pick request for the user for the current_pick
        pick_user_id = @draft.current_pick.team.uuid
        Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:start-' + pick_user_id, {})
      end

      render :text => 'success'
    else
      render :text => 'fail'
    end
  end

  def dispatch_push_event(channel, event_name, payload = {}, socket_id = nil)
    puts event_name, payload, socket_id
    Pusher[channel].trigger(event_name, payload, socket_id)
  end
  handle_asynchronously :dispatch_push_event

  def auth
    draft = self.resource
    team = draft.teams.first
    payload = {
      :user_id => current_user.id,
      :user_info => {
        :team_id => team.uuid
      }
    }

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], payload)
    render :json => response
  end
end

class League::DraftsController < SubdomainController
  layout 'drafts'
  before_filter :authenticate_user!
  before_filter :get_team!, :except => [:edit, :update, :destroy]

  singleton_belongs_to :league
  custom_actions :resource => [:start, :reset, :pick, :data]

  # starts the draft
  def start
    start! do |format|
      if !(@draft.status === :finished)
        @draft.start
        # trigger the pick request for the user for the current_pick
        #pick_user_id = @draft.current_pick.team.uuid
        #Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:pick:start-' + pick_user_id, {})
        format.text { render :text => "Starting draft for #{@league.name}" }  
      else
        raise 'A finished draft must be reset before it can be started.'
      end
    end
  end


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


  def auth
    @team.last_socket_id = params[:socket_id]
    @team.save

    payload = {
      :user_id => current_user.id,
      :user_info => {
        :team_id => @team.uuid
      },
      :current_pick_id => @team.league.draft.current_pick_id
    }

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], payload)
    render :json => response
  end


  private
    def get_team!
      @team = UserTeam.where{(league = @league) & (user = @current_user)}.first
    end
end

class League::DraftsController < SubdomainController
  layout 'drafts'
  before_filter :authenticate_user!
  before_filter :get_team!, :except => [:edit, :update, :destroy]

  singleton_belongs_to :league
  custom_actions :resource => [:start, :reset, :pick, :finish]

  # starts the draft
  def start
    start! do |format|
      if @draft.status.nil?
        @draft.start
      end

      if @draft.status === :started
        @draft.advance
        format.text { render :text => "Starting draft for #{@league.name}" }  
      else
        raise 'The draft is in an unknown state and must be reset before it can be started again.'
      end
    end
  end


  def reset
    reset! do |format|
      @draft.reset
      Pusher[Draft::CHANNEL_PREFIX + @draft.league.slug].delay.trigger('draft:reset', {})
      
      format.text { render :text => "Resetting draft for #{@league.name}" }
    end
  end

  # TODO: might want to notify and redirect users taking part in the draft IF we're ever going to
  # use this in production.
  def finish
    finish! do |format|
      @draft.advance(true)
      format.text { render :text => "Forcing finish of draft for #{@league.name}" }
    end
  end

  def auth
    @team.last_socket_id = params[:socket_id]
    @team.save

    payload = {
      :user_id => @team.uuid
    }

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], payload)
    render :json => response
  end


  private
    def get_team!
      @team = UserTeam.where{(league_id == my{@league.id}) & (user_id == my{current_user.id})}.first
    end
end

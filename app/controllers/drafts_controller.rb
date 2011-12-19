class DraftsController < ApplicationController
  before_filter :authenticate_user!
  

  def pick
    user = current_user
    user_team = user.user_team
    league = user_team.league

    person = Person.find(params[:player][:id])

    current_draft = Draft.current(league)

    Pick.create(
      :user_team => user_team,
      :person => person,
      :round => current_draft.current_round)

    data = {}
    data[:round_number] = current_draft.number_of_started_rounds

    data[:picks] = []
    current_draft.picks.each do |p|
      data[:picks] << [
        "#{p.person.display_name.full_name}",
        "#{p.user_team.name}"
      ]

    respond_to do |format|
      format.html
      format.json { render json: data[:picks] }
    end
  end

    data[:available_players] = []
    current_draft.available_players.each do |p|
      data[:available_players] << [
        "<input id='player_id_#{p.id}' name='player[id]' type='radio' value='#{p.id}'/>",
        "#{p.display_name.full_name}"
      ]
    end

    current_round = current_draft.current_round
    current_user_team = current_round.current_user_team
    data[:current_user_team] = current_user_team
    data[:my_turn] = data[:current_user_team] == user_team

    render :json => data
  end

  def reset_draft
    Draft.delete_all
    Pick.delete_all
    Round.delete_all
    PickingOrder.delete_all
  end

  def status
    @status = Draft.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @status }
    end
  end

  def index
    @teams = current_user.teams
  end

  def users
    @draft = Draft.find(params[:id])
    @users = @draft.users

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def available_players
    @draft = Draft.find(params[:id])
    @players = @draft.available_players
    total = @players.count
    respond_to do |format|
      format.html
      format.json { render json: { :results => @players, :total => total } }
    end
  end


  #### CUSTOM ACTIONS FOR PUSHER ####


  def push_available_players
    @draft = Draft.find(params[:id])
    @draft.push_available_players
    render :nothing => true
  end

  def push_draft_status
    @draft = Draft.find(params[:id])
    @draft.push_draft_status
    render :nothing => true
  end

  def roster
    @draft = Draft.find(params[:id])
    @user = current_user
    @team = @draft.teams.where("user_id = ?", @user.id)
    @picks = @draft.picks.where("person_id >= ?", 1)
    @picks = @picks.where("team_id = ?", @team).map(&:person_id)
    @roster = Salary.find(@picks)
   
    respond_to do |format|
      format.html
      format.json { render json: { :results => @roster } }
    end
  end

  def auto_pick
    @draft = Draft.find(params[:id])
    @draft.auto_pick
    render :nothing => true
  end

  def draft_auto_pick
    @draft = Draft.find(params[:id])
    @draft.draft_auto_pick
    render :json => true
  end

  #### END PUSHER ACTIONS ###

  def show
    
    @draft  = Draft.find(params[:id])
    @user = current_user
  # push the current draft status
    @draft.push_draft_status
  # push available players
  # @draft.push_available_players

  # current user's team
    @team = current_user.teams
      .where('league_id = ?', @draft.league_id)
      .limit(1)
      .first
  # current_draft = Draft.current_or_new(league)

  @draft.check_next_pick 

  # @round_number = current_draft.number_of_started_rounds
  # @picks = current_draft.picks
  # @available_players = current_draft.available_players
  # current_round = current_draft.current_round
  # @current_round = current_round
  # #@current_user_team = current_round.current_user_team
  # @current_user_team = user_team
  # @my_turn = @current_user_team == user_team
  # @your_team = user_team

  # #session[:data] = user
  # @logged_in_at = session
    respond_to do |format|
      format.html
      format.json { render json: @draft }
  
  end
end

# def updates
#   user = current_user
#   user_team = user.user_team
#   league = user_team.league

#   current_draft = Draft.current(league)
#   data = {}
#   if current_draft.nil? then
#     data[:finished] = true
#     return render :json => data
#   end

#   data ={}

#   current_round = current_draft.current_round
#   if current_round.nil?
#     data[:finished] = true
#     return render :json => data
#   end
#   current_user_team = current_round.current_user_team
#   if current_user_team.id != user_team.id &&
#       (current_user_team.user.last_seen.nil? ||
#       current_user_team.user.last_seen < current_round.started_at) then
#     current_round.picks.create(
#       :user_team => current_user_team,
#       :person => current_draft.available_players.first)
#     current_round = current_draft.current_round
#     if current_round.nil?
#       data[:finished] = true
#       return render :json => data
#     end
#     current_user_team = current_round.current_user_team
#   end

#   data[:picks] = []
#   current_draft.picks.each do |p|
#     data[:picks] << [
#       "#{p.person.display_name.full_name}",
#       "#{p.user_team.name}"
#     ]
#   end

#   data[:available_players] = []
#   current_draft.available_players.each do |p|
#     data[:available_players] << [
#       "<input id='player_id_#{p.id}' name='player[id]' type='radio' value='#{p.id}'/>",
#       "#{p.display_name.full_name}"
#     ]
#   end

#   data[:round_number] = current_draft.number_of_started_rounds
#   data[:current_user_team] = current_user_team
#   data[:my_turn] = data[:current_user_team] == user_team

#   render :json => data
# end

# def timeout
#   user = current_user
#   user_team = user.user_team
#   league = user_team.league

#   current_draft = Draft.current(league)
#   person = current_draft.available_players.first

#   Pick.create(
#     :user_team => user_team,
#     :person => person,
#     :round => current_draft.current_round)

#   data = {}
#   data[:round_number] = current_draft.number_of_started_rounds
#   data[:picks] = []
#   current_draft.picks.each do |p|
#     data[:picks] << [
#       "#{p.person.display_name.full_name}",
#       "#{p.user_team.name}"
#     ]
#   end

#   data[:available_players] = []
#   current_draft.available_players.each do |p|
#     data[:available_players] << [
#       "<input id='player_id_#{p.id}' name='player[id]' type='radio' value='#{p.id}'/>",
#       "#{p.display_name.full_name}"
#     ]
#   end

#   current_round = current_draft.current_round
#   current_user_team = current_round.current_user_team
#   data[:current_user_team] = current_user_team
#   data[:my_turn] = data[:current_user_team] == user_team

#   render :json => data
# end
end

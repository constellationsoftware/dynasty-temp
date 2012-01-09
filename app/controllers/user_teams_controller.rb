class UserTeamsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user_teams = UserTeam.all

    #@user_teams = league.user_teams        
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json =>{ :results => @user_teams }}
    end
  end

  def manage
   @cap = 75000000
   @title = "A Title"
   @team = UserTeam.find(params[:id])
   session[:user_team_id] = @team.id

   @user_team = @team
   @league = @team.league
   @current_user = current_user
   @team_manager = @team.user
   @other_teams = @league.teams.where(:user_id != @current_user.id)
   @clock = Clock.first.nice_time

   # game outcome
   if  @team.schedules.where(:week => @team.games.last.week).first
   @last_game =  @team.schedules.where(:week => @team.games.last.week).first
   end
   # Roster and positioning stuff
   @my_lineup = UserTeamLineup.find_or_create_by_user_team_id(@team.id)

   @my_season_payroll = @team.players.to_a.sum(&:amount)
   @my_weekly_payroll = @my_season_payroll / @team.schedules.count

   @my_starters = @team.player_team_records.where(:depth => 1)
   @my_bench = @team.player_team_records.where(:depth => 0)
   @my_ptr = @team.player_team_records
      @my_qb = @my_ptr.qb
      @my_wr = @my_ptr.wr
      @my_rb = @my_ptr.rb
      @my_te = @my_ptr.te
      @my_k  = @my_ptr.k

   # Research Stuff
   @all_players = Player.with_points_from_season(2011).order("points DESC")
   @signed_players = @league.players
   @unsigned_players = @all_players - @signed_players
   @positions = Position.all

   # Trades stuff
   @trade = Trade.all
   @my_players = @team.player_team_records

   @my_open_trades_offered = Trade.open.find_all_by_initial_team_id(@team.id)
   @my_open_trades_received = Trade.open.find_all_by_second_team_id(@team.id)

   @my_accepted_trades_offered = Trade.closed.accepted.find_all_by_initial_team_id(@team.id)
   @my_accepted_trades_received = Trade.closed.accepted.find_all_by_second_team_id(@team.id)

   @my_denied_trades_offered = Trade.closed.denied.find_all_by_initial_team_id(@team.id)
   @my_denied_trades_received = Trade.closed.denied.find_all_by_second_team_id(@team.id)


   # Waiver Wire Stuff

   @waiver_players = @league.player_team_records.where(:waiver => 1)


   # Create a New Trade

   @new_trade = Trade.new
   @new_trade.initial_team_id = @team.id
   @other_teams = @league.teams.where('id != ?', @user_team.id)
   @other_players = []
   @other_teams.each do |ot|
     ot.player_team_records.each do |otp|
       @other_players << otp.id
     end
   end
   @requestable_players = PlayerTeamRecord.find(@other_players)

   unless @current_user == @team_manager
    redirect_to root_path, :flash => { :info => "You aren't authorized to do that!"}
   end

  end

  def roster

  end


    # GET /user_teams/1
    # GET /user_teams/1.xml
  def show
    @team = UserTeam.find_by_name(params[:name])
    @user = current_user

    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @team }
    end
  end

    # GET /user_teams/new
    # GET /user_teams/new.xml
  def new
    @user_team = UserTeam.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user_team }
    end
  end

    # GET /user_teams/1/edit
  def edit
    @user_team = UserTeam.find(params[:id])
  end

    # POST /user_teams
    # POST /user_teams.xml
  def create
    @user_team = UserTeam.new(params[:user_team])
    @user_team.create_balance


    respond_to do |format|
      if @user_team.save
        format.html { redirect_to(@user_team, :notice => 'User team was successfully created.') }
        format.xml { render :xml => @user_team, :status => :created, :location => @user_team }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user_team.errors, :status => :unprocessable_entity }
      end
    end
  end

    # PUT /user_teams/1
    # PUT /user_teams/1.xml
  def update
    @user_team = UserTeam.find(params[:id])

    respond_to do |format|
      if @user_team.update_attributes(params[:user_team])
        format.html { redirect_to(@user_team, :notice => 'User team was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user_team.errors, :status => :unprocessable_entity }
      end
    end
  end

    # DELETE /user_teams/1
    # DELETE /user_teams/1.xml
  def destroy
    @user_team = UserTeam.find(params[:id])
    @user_team.destroy

    respond_to do |format|
      format.html { redirect_to(user_teams_url) }
      format.xml { head :ok }
    end
  end
end

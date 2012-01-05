class League::TradesController < SubdomainController
  before_filter :authenticate_user!

  # GET /trades
  # GET /trades.xml
  def index
    @trades = Trade.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @trades }
    end
  end

    # GET /trades/1
    # GET /trades/1.xml
  def show
    @trade = Trade.all
    @user_team = UserTeam.where(:user_id => current_user.id).where(:league_id => current_user.league_id).first
    @my_open_trades_offered = Trade.open.find_all_by_initial_team_id(@user_team.id)
    @my_open_trades_received = Trade.open.find_all_by_second_team_id(@user_team.id)

    @my_accepted_trades_offered = Trade.closed.accepted.find_all_by_initial_team_id(@user_team.id)
    @my_accepted_trades_received = Trade.closed.accepted.find_all_by_second_team_id(@user_team.id)

    @my_denied_trades_offered = Trade.closed.denied.find_all_by_initial_team_id(@user_team.id)
    @my_denied_trades_received = Trade.closed.denied.find_all_by_second_team_id(@user_team.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @trade }
    end
  end

    # GET /trades/new
    # GET /trades/new.xml
  def new
    @trade = League::Trade.new
    @user_team = UserTeam.where(:user_id => current_user.id).where(:league_id => current_user.league_id).first
    @my_players = @user_team.players
    @other_teams = @league.teams.where('id != ?', @user_team.id)
    @other_players = []
    @other_teams.each do |ot|
      ot.players.each do |otp|
        @other_players << otp.id
      end
    end
    @requestable_players = Player.find(@other_players)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @trade }
    end
  end

    # GET /trades/1/edit
  def edit
    @trade = League::Trade.find(params[:id])
  end

    # POST /trades
    # POST /trades.xml
  def create
    @trade = League::Trade.new(params[:trade])
    @user_team = UserTeam.where(:user_id => current_user.id).where(:league_id => current_user.league_id).first
    @requested_player = Player.find(@trade.requested_player_id)
    @ptr = @league.player_team_records.where(:player_id => @requested_player.id).first

    @trade.initial_team_id = @user_team.id
    @trade.league_id = @league.id
    @trade.second_team_id =  UserTeam.find(@ptr.user_team_id).id
    @trade.offered_at = Clock.first.time
    @trade.open = TRUE
    @trade.accepted = FALSE
    respond_to do |format|
      if @trade.save
        format.html { render :action => "edit" }
        format.xml { render :xml => @trade, :status => :created, :location => @trade }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @trade.errors, :status => :unprocessable_entity }
      end
    end
  end

    # PUT /trades/1
    # PUT /trades/1.xml
  def update
    @trade = League::Trade.find(params[:id])

    respond_to do |format|
      if @trade.update_attributes(params[:trade])
        format.html { redirect_to(@trade, :notice => 'Trade was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @trade.errors, :status => :unprocessable_entity }
      end
    end
  end

    # DELETE /trades/1
    # DELETE /trades/1.xml
  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy

    respond_to do |format|
      format.html { redirect_to(trades_url) }
      format.xml { head :ok }
    end
  end
end

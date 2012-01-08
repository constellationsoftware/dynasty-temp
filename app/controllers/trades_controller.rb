class TradesController < ApplicationController
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
    @trade = Trade.new
    @user_team = UserTeam.where(:user_id => current_user.id).where(:league_id => current_user.league_id).first
    @my_players = @user_team.player_team_records
    @other_teams = @league.teams.where('id != ?', @user_team.id)
    @other_players = []
    @other_teams.each do |ot|
      ot.player_team_records.each do |otp|
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
    @trade = Trade.find(params[:id])
  end

    # POST /trades
    # POST /trades.xml b
  def create
    @trade = Trade.new(params[:trade])
    @user_team = UserTeam.where(:user_id => current_user.id)
    @requested_player = PlayerTeamRecord.find(@trade.requested_player_id)

    @trade.initial_team_id = @user_team.id
    @trade.league_id = @user_team.league_id
    @trade.second_team_id =  UserTeam.find(@requested_player.user_team_id)
    @trade.offered_at = Clock.first.time
    @trade.open = TRUE
    @trade.accepted = FALSE
    respond_to do |format|
      if @trade.save
        format.html { redirect_to :back, :flash => { :info => "You offered #{@requested_player.user_team.name} a trade!" } }
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
    @trade = Trade.find(params[:id])

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


  def retract
    @trade = Trade.find(params[:trade_id])
    @trade.open = 0
    @trade.denied_at = Clock.first.nice_time
    @trade.save
    respond_to do |format|
      format.html { redirect_to :back, :flash => { :info => "You retracted your offer to #{@trade.requested_player.user_team.name}" } }
      format.xml { head :ok }
    end
  end

  def reject
    @trade = Trade.find(params[:trade_id])
    @trade.open = 0
    @trade.denied_at = Clock.first.nice_time
    @trade.save
    respond_to do |format|
      format.html { redirect_to :back, :flash => { :info => "You rejected the offer from #{@trade.offered_player.user_team.name}" } }
      format.xml { head :ok }
    end
  end

  def accept
    @trade = Trade.find(params[:trade_id])
    @trade.open = 0
    @trade.accepted = 1
    @trade.accepted_at = Clock.first.nice_time
    @trade.save

    # process trade transaction

    ### Todo extract all of this to model methods
    # Find the teams in question
    @initial_team = @trade.initial_team
    @second_team = @trade.second_team

    # Swap PTR's & Update timestamps and clear lineups!
    @offered_ptr = @trade.offered_player
    @requested_ptr = @trade.requested_player


    @offered_ptr.user_team_id = @second_team.id
    @requested_ptr.user_team_id = @initial_team.id
    @offered_ptr.depth = 0
    @requested_ptr.depth = 0
    @offered_ptr.details = "Traded from #{@initial_team.name}"
    @requested_ptr.details = "Traded from #{@second_team.name}"
    @offered_ptr.save
    @requested_ptr.save


    # swap balances - does nothing right now
    @offered_cash = @trade.offered_cash
    @requested_cash = @trade.requested_cash

    #@initial_team.balance.balance_cents = @initial_team.balance.balance_cents - @offered_cash
    #@initial_team.balance.balance_cents = @initial_team.balance.balance_cents + @offered_cash

    #@second_team.balance.balance_cents = @second_team.balance.balance_cents + @offered_cash
    #@second_team.balance.balance_cents = @second_team.balance.balance_cents - @offered_cash


    # Do nothing with picks for right now
    # @offered_picks = @trade.offered_picks
    # @requested_picks = @trade.requested_picks



    respond_to do |format|
      format.html { redirect_to :back, :flash => { :info => "You accepted the offer from #{@trade.requested_player.user_team.name} to trade #{@requested_ptr.name} for #{@offered_ptr.name}" } }
      format.xml { head :ok }
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

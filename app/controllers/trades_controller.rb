class TradesController < ApplicationController
    before_filter :authenticate_user!

    respond_to :html

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
        @team = Team.where(:user_id => current_user.id).where(:league_id => current_user.league_id).first
        @my_open_trades_offered = Trade.open.find_all_by_initial_team_id(@team.id)
        @my_open_trades_received = Trade.open.find_all_by_second_team_id(@team.id)

        @my_accepted_trades_offered = Trade.closed.accepted.find_all_by_initial_team_id(@team.id)
        @my_accepted_trades_received = Trade.closed.accepted.find_all_by_second_team_id(@team.id)

        @my_denied_trades_offered = Trade.closed.denied.find_all_by_initial_team_id(@team.id)
        @my_denied_trades_received = Trade.closed.denied.find_all_by_second_team_id(@team.id)

        respond_to do |format|
            format.html # show.html.erb
            format.xml { render :xml => @trade }
        end
    end

    # GET /trades/new
    # GET /trades/new.xml
    def new
        @trade = Trade.new
        @team = current_user.team
        @league = @team.league
        @selected_player = PlayerTeam.find(params[:pid])
        @my_players = @team.player_teams
        @other_teams = @league.teams.where('id != ?', @team.id)
        @other_players = []


        @other_teams.each do |ot|
            ot.player_teams.each do |otp|
                @other_players << otp.id
            end
        end
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
        @trade = League::Trade.new(params[:trade])
        @offered_player = PlayerTeam.find(@trade.offered_player_id)
        @requested_player = PlayerTeam.find(@trade.requested_player_id)
        @trade.initial_team_id = @offered_player.team_id
        @trade.second_team_id = @requested_player.team_id

        @trade.offered_at = Clock.first.time
        @trade.open = TRUE
        @trade.accepted = FALSE
        @trade.save
        respond_to do |format|
            if @trade.save
                format.html { redirect_to '/front_office/trades', :flash => {:info => "You offered #{@requested_player.team.name} a trade!"} }
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
        @trade.denied_at = Time.now
        @trade.save
        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You retracted your offer to #{@trade.requested_player.team.name}"} }
            format.xml { head :ok }
        end
    end

    def reject
        @trade = Trade.find(params[:trade_id])
        @trade.open = 0
        @trade.denied_at = Time.now
        @trade.save
        respond_to do |format|
            format.html { redirect_to :back, :flash => {:info => "You rejected the offer from #{@trade.offered_player.team.name}"} }
            format.xml { head :ok }
        end
    end

    def accept
        trade = Trade.find(params[:trade_id])
        trade.open = 0
        trade.accepted = 1
        trade.accepted_at = Time.now
        trade.save!
        redirect_to :back
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

class UserTeamsController < ApplicationController
  #before_filter :authenticate_user!
  def index
    @user_teams = UserTeam.all

    #@user_teams = league.user_teams        
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json =>{ :results => @user_teams }}
    end
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

class UsersController < ApplicationController
  # GET /Users
  # GET /Users.json




  def index
    @time = Time.now
    Thread.new do
      100.times {
        sleep 1
        Pusher['chrono-channel'].trigger('update', Time.now)
      }
    end
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb

      format.json { render json: { :results => @users }}
    end
  end

    # GET /Users/1
    # GET /Users/1.json

  def home
    @user = current_user
  end
  
  def show
    @user    = User.find(params[:id])
  #  @players = @user.person_phases.find(:all, :include => :position)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user.inspect }
    end
  end

    # GET /Users/new
    # GET /Users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

    # GET /Users/1/edit
  def edit
    @user = User.find(params[:id])
  end

    # POST /Users
    # POST /Users.json
  def create
    @user = User.new(params[:User])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

    # PUT /Users/1
    # PUT /Users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:User])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

    # DELETE /Users/1
    # DELETE /Users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(Users_url) }
      format.json { head :ok }
    end
  end
end

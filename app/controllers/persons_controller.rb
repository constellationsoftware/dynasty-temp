class PersonsController < ApplicationController
  # GET /
  # GET /persons.xml
  def index
    @persons    = Person.all
    @positions = Position.all

    respond_to do |format|
      format.html # indexbak.html.erb
      format.xml { render :xml => @persons }
    end
  end

  def position
    @positions = Position.find(params[:id])
  end

    # GET /persons/1
    # GET /persons/1.xml
  def show
    Timecop.freeze(2011,10,15)
    @person = Person.find(params[:id])
    @stats        = @person.stats.current.event_stat
    @score        = @person.person_scores.order("created_at").last
    @scores       = @person.person_scores.order("created_at DESC").all
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @person }
    end
  end

    # GET /persons/new
    # GET /persons/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @person }
    end
  end

    # GET /persons/1/edit
  def edit
    @person = Person.find(params[:id])
  end

    # POST /persons
    # POST /persons.xml
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.xml { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

    # PUT /persons/1
    # PUT /persons/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

    # DELETE /persons/1
    # DELETE /persons/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(persons_url) }
      format.xml { head :ok }
    end
  end
end

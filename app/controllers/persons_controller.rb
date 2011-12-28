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
    #Timecop.freeze(2011,12, 26)
    @person = Person.find(params[:id])
    @last_years_stats = @person.stats.event_stat
    @stats        = @person.stats.current.event_stat
    @last_season     = @person.stats.subseason_stat.last_season
    @score        = @person.person_scores.order("created_at").last
    @scores       = @person.person_scores.order("created_at DESC").all

    stats = {
        :passing_stats => @last_season.andand.passing_stat.first.andand.stat_repository.score_modifier,
        :rushing_stats => @last_season.andand.rushing_stat.first.andand.stat_repository.score_modifier,
        :defensive_stats => @last_season.andand.defensive_stat.first.andand.stat_repository.score_modifier,
        :sacks_against_stats => @last_season.andand.sacks_against_stat.first.andand.stat_repository.score_modifier,
        :scoring_stat => @last_season.andand.scoring_stat.first.andand.stat_repository.score_modifier,
        :special_teams_stat => @last_season.andand.special_teams_stat.first.andand.stat_repository.score_modifier,
        :passing_yards => @last_season.andand.passing_stat.first.andand.stat_repository.score_modifier
    }

    result = {
        :success => true,
        :person => @person,
        :display_name => @person.display_name,
        :position => @person.current_position,
        :stats => stats

    }
    #json[:first_name] = @person.display_name
    #json[:ranking] = "123"
    #json[:last_years_stats] = @last_years_stats


    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @person }
      format.json { render :json => result }
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

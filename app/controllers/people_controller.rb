class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  before_filter :authenticate_user!
  def index
    @teams = Team.all
    @positions = Position.all
    #people = Person.all
    @people = PersonPhase.current_phase.joins(:person)
    #data = {}
    #data[:players] = []
    #people.each do |p|
      #data[:players] << [
          #"id: #{p.id}",
          #"player_key: #{p.person_key}",
          #"full_name: #{p.display_name.full_name}",
          #"position: #{p.person_phase.position}",
          #"position_depth: #{p.person_phase.regular_position_depth}",
          #"score: #{p.person_score.score}",
          #"salary: #{p.salary.contract_amount}"
          #"#{p.salary.inspect if p.salary}",
          #"#{p.person_scores.last.inspect if p.person_scores.last}"
      #]
    #end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def draftable
    @draftable = DraftablePlayer.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :ok }
    end
  end
end

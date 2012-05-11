class PersonPhasesController < ApplicationController
    # GET /person_phases
    # GET /person_phases.xml
    def index
        @person_phases = PersonPhase.all


        respond_to do |format|
            format.json { render :json => @person_phases }
            format.html # indexbak.html.erb
            format.xml { render :xml => @person_phases }
        end
    end

    # GET /person_phases/1
    # GET /person_phases/1.xml
    def show
        @person_phase = PersonPhase.find(params[:id])
        @stats = @person_phase.person.stats.all
        @score = @person_phase.person.person_scores.order("created_at").last
        @scores = @person_phase.person.person_scores.order("created_at DESC").all


        #@passing_score = @stats.american_football_passing_stats.passes_touchdowns

        respond_to do |format|

            format.json { render :json => @person_phase }
            format.html # show.html.erb
            format.xml { render :xml => @person_phase }
        end
    end

    # GET /person_phases/new
    # GET /person_phases/new.xml
    def new
        @person_phase = PersonPhase.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml { render :xml => @person_phase }
        end
    end

    # GET /person_phases/1/edit
    def edit
        @person_phase = PersonPhase.find(params[:id])
    end

    # POST /person_phases
    # POST /person_phases.xml
    def create
        @person_phase = PersonPhase.new(params[:person_phase])

        respond_to do |format|
            if @person_phase.save
                format.html { redirect_to(@person_phase, :notice => 'Person phase was successfully created.') }
                format.xml { render :xml => @person_phase, :status => :created, :location => @person_phase }
            else
                format.html { render :action => "new" }
                format.xml { render :xml => @person_phase.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /person_phases/1
    # PUT /person_phases/1.xml
    def update
        @person_phase = PersonPhase.find(params[:id])

        respond_to do |format|
            if @person_phase.update_attributes(params[:person_phase])
                format.html { redirect_to(@person_phase, :notice => 'Person phase was successfully updated.') }
                format.xml { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml { render :xml => @person_phase.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /person_phases/1
    # DELETE /person_phases/1.xml
    def destroy
        @person_phase = PersonPhase.find(params[:id])
        @person_phase.destroy

        respond_to do |format|
            format.html { redirect_to(person_phases_url) }
            format.xml { head :ok }
        end
    end

end

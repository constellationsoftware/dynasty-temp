class PersonScoresController < ApplicationController
  # GET /person_scores
  # GET /person_scores.xml
  def index
    #update person scores
    Person.find_each do |person|
      calcscore = PersonScore.new
      calcscore.score  = 0
      calcscore.person_id = person.id

      person.stats.each do |stat|
        calcscore.score += stat.stat_repository.score_modifier
      end
      calcscore.save
    end

    @person_scores = PersonScore.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @person_scores }
    end
  end

    # GET /person_scores/1
    # GET /person_scores/1.xml
  def show
    @person_score = PersonScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @person_score }
    end
  end

    # GET /person_scores/new
    # GET /person_scores/new.xml
  def new
    @person_score = PersonScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @person_score }
    end
  end

    # GET /person_scores/1/edit
  def edit
    @person_score = PersonScore.find(params[:id])
  end

    # POST /person_scores
    # POST /person_scores.xml
  def create
    @person_score = PersonScore.new(params[:person_score])

    respond_to do |format|
      if @person_score.save
        format.html { redirect_to(@person_score, :notice => 'Person score was successfully created.') }
        format.xml { render :xml => @person_score, :status => :created, :location => @person_score }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @person_score.errors, :status => :unprocessable_entity }
      end
    end
  end

    # PUT /person_scores/1
    # PUT /person_scores/1.xml
  def update
    @person_score = PersonScore.find(params[:id])

    respond_to do |format|
      if @person_score.update_attributes(params[:person_score])
        format.html { redirect_to(@person_score, :notice => 'Person score was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @person_score.errors, :status => :unprocessable_entity }
      end
    end
  end

    # DELETE /person_scores/1
    # DELETE /person_scores/1.xml
  def destroy
    @person_score = PersonScore.find(params[:id])
    @person_score.destroy

    respond_to do |format|
      format.html { redirect_to(person_scores_url) }
      format.xml { head :ok }
    end
  end

end

class PersonsController < InheritedResources::Base
    respond_to :json, :html, :xml

    #has_scope :with_points_from_season, :default => 'last'

    # GET /
    # GET /persons.xml
    def index
        @persons = Person.all
        @positions = Position.all

        respond_to do |format|
            format.html # indexbak.html.erb
            format.xml { render :xml => @persons }
        end
    end


    # GET /persons/1
    # GET /persons/1.xml
=begin
  def show
    Timecop.freeze(2011,10, 26)
    @person = Person.find(params[:id])
    @last_years_stats = @person.stats.event_stat
    @stats        = @person.stats.current.event_stat
    @last_season     = @person.stats.subseason_stat.last_season
    @current_season = @person.stats.subseason_stat.this_season
    @career = @person.stats.career_stat
    seasons = @person.stats.subseason_stat.andand.core_stat.count
    @score        = @person.person_scores.order("created_at").last
    @scores       = @person.person_scores.order("created_at DESC").all

    last_season_stats = {
        :passing_stats => @last_season.andand.passing_stat.first.andand.stat_repository.andand.score_modifier,
        :rushing_stats => @last_season.andand.rushing_stat.first.andand.stat_repository.andand.score_modifier,
        :defensive_stats => @last_season.andand.defensive_stat.first.andand.stat_repository.andand.score_modifier,
        :sacks_against_stats => @last_season.andand.sacks_against_stat.first.andand.stat_repository.andand.score_modifier,
        :scoring_stat => @last_season.andand.scoring_stat.first.andand.stat_repository.andand.score_modifier,
        :special_teams_stat => @last_season.andand.special_teams_stat.first.andand.stat_repository.andand.score_modifier
    }

    current_season_stats = {
        :passing_stats => @current_season.andand.passing_stat.first.andand.stat_repository.andand.score_modifier,
        :rushing_stats => @current_season.andand.rushing_stat.first.andand.stat_repository.andand.score_modifier,
        :defensive_stats => @current_season.andand.defensive_stat.first.andand.stat_repository.andand.score_modifier,
        :sacks_against_stats => @current_season.andand.sacks_against_stat.first.andand.stat_repository.andand.score_modifier,
        :scoring_stat => @current_season.andand.scoring_stat.first.andand.stat_repository.andand.score_modifier,
        :special_teams_stat => @current_season.andand.special_teams_stat.first.andand.stat_repository.andand.score_modifier
    }

    career_stats = {
        :passing_stats => @career.andand.passing_stat.first.andand.stat_repository.andand.score_modifier,
        :rushing_stats => @career.andand.rushing_stat.first.andand.stat_repository.andand.score_modifier,
        :defensive_stats => @career.andand.defensive_stat.first.andand.stat_repository.andand.score_modifier,
        :sacks_against_stats => @career.andand.sacks_against_stat.first.andand.stat_repository.andand.score_modifier,
        :scoring_stat => @career.andand.scoring_stat.first.andand.stat_repository.andand.score_modifier,
        :special_teams_stat => @career.andand.special_teams_stat.first.andand.stat_repository.andand.score_modifier
    }

    career_info = {

    }


    result = {
        :success => true,
        :person => @person,
        :first_name => @person.display_name.first_name,
        :last_name => @person.display_name.last_name,
        :id => @person.id,
        :position => @person.current_position,
        :last_season_score => last_season_stats,
        :this_season_score => current_season_stats,
        :career_score => career_stats,
        :career_info => career_info,
        :seasons_played => seasons.to_i,
        :contract => doc.css(".playerValue").first.text,
        :roto => @photo
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
=end

    def show
        show! do |format|
            format.json { render :text => @person.to_json(
                :include => {
                    :display_name => {},
                    :positions => {},
                    :person_phases => {},
                    :stats => {:methods => [:points]}
                }
            ) }
            format.html {

                @person = Person.find(params[:id])
                # get contract info
                #team = @person.current_team.name.gsub! /\s+/, '-'
                #name = @person.display_name.full_name.gsub! /\s+/, '-'
                #url = "http://www.spotrac.com/nfl/#{team}/#{name}"
                #spotrac_doc = Nokogiri::HTML(open(url))
                #@contract = spotrac_doc.css("span.playerValue")
                #@person.contract.summary = @contract[0].andand.text
                #@person.contract.amount = @contract[2].andand.text.strip!
                #@person.contract.end_year = @contract[3].andand.text
                #@person.contract.free_agent_year = @contract[4].andand.text
                #@person.contract.save

                #
                # @salary = @spotract_doc.css(".salaryTable salaryInfo")
                # unless @person.photo.url do
                #   # try rotoworld
                #   roto_url = "http://rotoworld.com/content/playersearch.aspx?searchname=#{@person.display_name.last_name},#{@person.display_name.first_name}"
                #   roto_doc = Nokogiri::HTML(open(roto_url))
                #   @roto_doc = roto_doc
                #
                #   @photo = @roto_doc.css("#cp1_ctl00_imgPlayerPhoto")
                #   @photo_url = "http://rotoworld.com#{@photo.attribute('src').to_s}"
                #   @person.photo.url = @photo_url
                #   @person.photo.save
                # end
                #
            }
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

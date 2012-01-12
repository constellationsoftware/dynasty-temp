class DisplayNamesController < ApplicationController
    # GET /display_names
    # GET /display_names.xml
    def index
        DisplayName.update_all("entity_type = 'Team'", "entity_type LIKE '%teams%'")
        DisplayName.update_all("entity_type = 'Person'", "entity_type LIKE '%persons%'")
        DisplayName.update_all("entity_type = 'Affiliation'", "entity_type LIKE '%affiliations%'")

        Stat.update_all("stat_holder_type = 'Team'", "stat_holder_type LIKE '%teams%'")
        Stat.update_all("stat_holder_type = 'Person'", "stat_holder_type LIKE '%persons%'")
        Stat.update_all("stat_holder_type = 'Affiliation'", "stat_holder_type LIKE '%affiliations%'")

        @stats = Stat.all
        @display_names = DisplayName.all

        respond_to do |format|
            format.html # indexbak.html.erb
            format.xml { render :xml => @display_names }
        end
    end


    # GET /display_names/1
    # GET /display_names/1.xml
    def show
        @display_name = DisplayName.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml { render :xml => @display_name }
        end
    end

    # GET /display_names/new
    # GET /display_names/new.xml
    def new
        @display_name = DisplayName.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml { render :xml => @display_name }
        end
    end

    # GET /display_names/1/edit
    def edit
        @display_name = DisplayName.find(params[:id])
    end

    # POST /display_names
    # POST /display_names.xml
    def create
        @display_name = DisplayName.new(params[:display_name])

        respond_to do |format|
            if @display_name.save
                format.html { redirect_to(@display_name, :notice => 'Display name was successfully created.') }
                format.xml { render :xml => @display_name, :status => :created, :location => @display_name }
            else
                format.html { render :action => "new" }
                format.xml { render :xml => @display_name.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /display_names/1
    # PUT /display_names/1.xml
    def update
        @display_name = DisplayName.find(params[:id])

        respond_to do |format|
            if @display_name.update_attributes(params[:display_name])
                format.html { redirect_to(@display_name, :notice => 'Display name was successfully updated.') }
                format.xml { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml { render :xml => @display_name.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /display_names/1
    # DELETE /display_names/1.xml
    def destroy
        @display_name = DisplayName.find(params[:id])
        @display_name.destroy

        respond_to do |format|
            format.html { redirect_to(display_names_url) }
            format.xml { head :ok }
        end
    end
end

class DynastyDollarsController < ApplicationController
    # GET /dynasty_dollars
    # GET /dynasty_dollars.xml
    def index
        @dynasty_dollars = DynastyDollar.all

        respond_to do |format|
            format.html # index.html.erb
            format.xml { render :xml => @dynasty_dollars }
        end
    end

    # GET /dynasty_dollars/1
    # GET /dynasty_dollars/1.xml
    def show
        @dynasty_dollar = DynastyDollar.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml { render :xml => @dynasty_dollar }
        end
    end

    # GET /dynasty_dollars/new
    # GET /dynasty_dollars/new.xml
    def new
        @dynasty_dollar = DynastyDollar.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml { render :xml => @dynasty_dollar }
        end
    end

    # GET /dynasty_dollars/1/edit
    def edit
        @dynasty_dollar = DynastyDollar.find(params[:id])
    end

    # POST /dynasty_dollars
    # POST /dynasty_dollars.xml
    def create
        @dynasty_dollar = DynastyDollar.new(params[:dynasty_dollar])

        respond_to do |format|
            if @dynasty_dollar.save
                format.html { redirect_to(@dynasty_dollar, :notice => 'Dynasty dollar was successfully created.') }
                format.xml { render :xml => @dynasty_dollar, :status => :created, :location => @dynasty_dollar }
            else
                format.html { render :action => "new" }
                format.xml { render :xml => @dynasty_dollar.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /dynasty_dollars/1
    # PUT /dynasty_dollars/1.xml
    def update
        @dynasty_dollar = DynastyDollar.find(params[:id])

        respond_to do |format|
            if @dynasty_dollar.update_attributes(params[:dynasty_dollar])
                format.html { redirect_to(@dynasty_dollar, :notice => 'Dynasty dollar was successfully updated.') }
                format.xml { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml { render :xml => @dynasty_dollar.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /dynasty_dollars/1
    # DELETE /dynasty_dollars/1.xml
    def destroy
        @dynasty_dollar = DynastyDollar.find(params[:id])
        @dynasty_dollar.destroy

        respond_to do |format|
            format.html { redirect_to(dynasty_dollars_url) }
            format.xml { head :ok }
        end
    end
end

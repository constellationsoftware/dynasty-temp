class MessagesController < InheritedResources::Base
    def show
        @clock = Clock.first
        respond_to do |format|
            format.html { render :json => @clock.time.to_date }
            format.json { render :json => @clock.flatten }
        end
    end

end

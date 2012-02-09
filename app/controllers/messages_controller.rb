class MessagesController < InheritedResources::Base
    def show
        @message = Message.first
        respond_to do |format|
            format.html { render :json => @message.content }
            format.json { render :json => @message.content }
        end
    end
end

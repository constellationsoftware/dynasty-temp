class UsersController < InheritedResources::Base
    before_filter :authenticate_user!, :except => :signup

    def home
        @teams = current_user.teams

        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @teams }
        end
    end

    def signup

    end
end

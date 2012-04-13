class UsersController < InheritedResources::Base
    before_filter :authenticate_user!, :except => :signup

    def home
        @team = current_user.team

        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @team }
        end
    end

    def signup

    end
end

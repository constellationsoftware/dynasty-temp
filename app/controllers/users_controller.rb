class UsersController < InheritedResources::Base
    before_filter :authenticate_user!, :except => :signup

    def home
        @teams = current_user.teams
    end

    def signup

    end
end

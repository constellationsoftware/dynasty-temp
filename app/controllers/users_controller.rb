class UsersController < InheritedResources::Base
    before_filter :authenticate_user!

    def home
        @teams = current_user.teams
    end
end

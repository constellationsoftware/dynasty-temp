class Users::TeamController < ApplicationController
    respond_to :html

    def show
        @team = Team.find_by_user_id current_user.id
        respond_with(@team)
    end

    def edit
        @team = current_user.team
    end

    def update

        redirect_to root_path
    end
end

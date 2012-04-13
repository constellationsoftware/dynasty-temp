class Users::TeamController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html
    helper_method :sub_sections

    def show
        @team = Team.find_by_user_id current_user.id
        respond_with(@team)
    end

    def edit
    end

    def sub_sections
        %w( review roster manage trade waiver finance league_review )
    end
end

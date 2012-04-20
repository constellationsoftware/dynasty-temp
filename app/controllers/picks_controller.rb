class PicksController < ApplicationController
    respond_to :html, :json

    def update
        if @pick = Pick.find(params[:id])
            @pick.update_attributes! params[:pick]
            respond_with @pick
        end
    end
end

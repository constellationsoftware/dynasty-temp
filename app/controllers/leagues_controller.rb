class LeaguesController < InheritedResources::Base
    before_filter :authenticate_user!
    respond_to :html, :json

    def create
        create! do |success, failure|
            resource.manager = current_user
            resource.save
            success.html{ redirect_to root_path }
        end
    end

    def update
        update! do |success, failure|
            success.html{ redirect_to root_path }
        end
    end
end

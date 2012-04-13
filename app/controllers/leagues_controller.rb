class LeaguesController < InheritedResources::Base
    before_filter :authenticate_user!
    respond_to :html, :json

    has_scope :with_manager, :type => :boolean

    def create
        create! do |success, failure|
            resource.public = false
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

    protected
        def collection
            if !!params[:page] && !!params[:limit]
                @leagues = end_of_association_chain
                @total = @leagues.size
                @leagues = @leagues.page(params[:page]).per(params[:limit])
            else
                @leagues = end_of_association_chain
            end
        end
end

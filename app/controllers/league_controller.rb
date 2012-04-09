class LeagueController < InheritedResources::Base
    before_filter :inject_slug_as_id

    custom_actions :resource => :home
    actions :only => :home

    private
        def inject_slug_as_id
            params[:id] = request.subdomain
        end
end

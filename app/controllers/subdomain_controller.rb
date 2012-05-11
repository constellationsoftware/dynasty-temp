class SubdomainController < InheritedResources::Base
    before_filter :get_league_from_subdomain

    private
    def get_league_from_subdomain
        @league = League.find_by_slug!(request.subdomain)
    end
end

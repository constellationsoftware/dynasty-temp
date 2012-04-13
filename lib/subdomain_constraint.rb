class SubdomainConstraint
    def self.matches?(request)
        case request.subdomain
            when !present?, 'www', '', nil
                false
            else
                request.params[:league_slug] = request.subdomain
                true
        end
    end
end

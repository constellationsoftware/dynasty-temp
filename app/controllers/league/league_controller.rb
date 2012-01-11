class League::LeagueController < SubdomainController
    defaults :resource_class => League,
             :collection_name => 'leagues',
             :route_prefix => 'league',
             :instance_name => 'league',
             :singleton => true,
             :finder => :find_by_slug

    actions :all, :except => [:index]

    protected
    def resource
        get_resource_ivar || set_resource_ivar(end_of_association_chain.send(resource_instance_name))
    end
end

class League::TeamController < SubdomainController
    before_filter :authenticate_user!
    defaults :resource_class => UserTeam, :instance_name => 'team'
    respond_to :json

    has_scope :with_games, :type => :boolean do |controller, scope|
        scope.with_schedule
    end

    def resource
        @team = end_of_association_chain
            .where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first

        if current_scopes.has_key? :with_games
            @games = @team.schedules
            @ratio = Schedule.ratio(@games)
        end
    end
end

class Leagues::Team::GamesController < SubdomainController
    before_filter :authenticate_user!, :get_team!
    defaults :resource_class => Game, :collection_name => 'games', :instance_name => 'game'
    respond_to :json

    has_scope :order_by_week, :type => :boolean, :default => true do |controller, scope|
        scope
    end

    protected
        def collection
            home_games = end_of_association_chain.with_home_team.where{ home_team_id == my{ @team.id } }
            away_games = end_of_association_chain.with_away_team.where{ away_team_id == my{ @team.id } }
            @games = (home_games + away_games).sort{ |a, b| a.date <=> b.date } if current_scopes[:order_by_week]
        end

    private
        def get_team!
            @team = Team.where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }.first
        end
end

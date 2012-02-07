class League::Team::PlayersController < SubdomainController
    before_filter :authenticate_user!, :get_team_id!
    defaults :resource_class => PlayerTeamRecord, :collection_name => 'player_teams', :instance_name => 'player_team'
    custom_actions :resource => [ :bench, :start ]
    respond_to :json

    has_scope :has_depth, :only => :index
    has_scope :roster, :type => :boolean do |controller, scope|
        # can't do join subqueries otherwise :(
        scope.joins{[ player_name, contract, position ]}
            .select{[ id, depth, contract.bye_week, position.abbreviation, player_name.first_name, player_name.last_name ]}
    end

    def bench
        @player_team = resource
        @player_team.depth = 0
        update!
    end

    def start
        @player_team = resource
        @player_team.depth = 1
        update!
    end

    def destroy
        @player_team = PlayerTeamRecord.find(params[:id])
        @player_team.details = "Dropped by #{@player_team.team.name} on #{Clock.first.nice_time}"
        @player_team.user_team_id = 0
        @player_team.waiver = 1
        @player_team.save!

        Juggernaut.publish('/observer', {
            type:   :destroy,
            id:     @player_team.id,
            class:  'Player',
            record: {
                :id =>          @player_team.id,
                :depth =>       @player_team.depth,
                :bye_week =>    @player_team.contract.bye_week,
                :position =>    @player_team.position.abbreviation.upcase,
                :first_name =>  @player_team.player_name.first_name,
                :last_name =>   @player_team.player_name.last_name,
                :contract =>    @player_team.contract.amount
            }
        },
        :except => request.headers["X-Session-ID"])
        render :text => 'success'
    end

    protected
        def resource
            @player_team = end_of_association_chain
                .where{ (user_team_id == my{ @team_id }) & (id == my{ params[:player_id] }) }
                .first
        end

        def collection
            @player_teams = end_of_association_chain
                .where{ (user_team_id == my{ @team_id }) & (current == 1) }

            if params[:order_by_name] && params[:order_by_name].to_i === 1
                @player_teams.sort!{ |a, b| "#{ a.last_name.downcase } #{ a.first_name.downcase }" <=> "#{ b.last_name.downcase } #{ b.first_name.downcase }" }
            end
        end

    private
        def get_team_id!
            @team_id = UserTeam.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

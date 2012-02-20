class League::Team::RosterController < SubdomainController
    before_filter :authenticate_user!, :get_team_id!
    defaults :resource_class => PlayerTeamRecord, :collection_name => 'player_teams', :instance_name => 'player_team'
    respond_to :json

    has_scope :bench, do |controller, scope|
        scope.has_depth(0)
    end

    has_scope :with_player_name, :type => :boolean
    has_scope :with_player_contract, :type => :boolean
    has_scope :with_position, :type => :boolean
    has_scope :with_player_points, :type => :boolean

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
                :bye_week =>    @player_team.player_contract.bye_week,
                :position =>    @player_team.player_position.abbreviation.upcase,
                :first_name =>  @player_team.player_name.first_name,
                :last_name =>   @player_team.player_name.last_name,
                :contract =>    @player_team.player_contract.amount
            }
        },
        :except => request.headers["X-Session-ID"])
        render :text => 'success'
    end

    protected
        def collection
            @player_teams = end_of_association_chain.where{ user_team_id == my{ @team_id } }
        end

    private
        def get_team_id!
            @team_id = UserTeam.select{ 'id' }
                .where{ (league_id == my{ @league.id }) & (user_id == my{ current_user.id }) }
                .first
                .id
        end
end

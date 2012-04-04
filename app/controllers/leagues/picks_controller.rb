class Leagues::PicksController < SubdomainController
    before_filter :authenticate_user!, :get_team!

    has_scope :draft_data, :type => :boolean, :default => true, :only => :index
    respond_to :json

    def index
        index! do |format|
            result = {
                :success => true,
                :picks => @picks
            }
            format.json { render :text => result.to_json(
                :except => [:draft_id],
                :include => {
                    :team => {:except => [:league_id, :uuid]}
                }
            ) }
        end
    end

    def test_update
        @pick = Pick.find(params[:id])
        if @pick
            @pick.player_id = params[:player_id]
            @pick.save
        end
        render :json => @pick
    end

    def update
        update! do |format|
            # move this somewhere else I guess
            socket_id ||= @pick.team.last_socket_id

            puts "PICK UPDATE"
            payload = {
                :player => { :id => @pick.player.id, :name => @pick.player.full_name },
                :team => { :id => @pick.team.id, :name => @pick.team.name },
                :pick => @pick
            }
            Pusher[Draft::CHANNEL_PREFIX + @pick.draft.league.slug].delay.trigger('draft:pick:update', payload, socket_id)
            @pick.draft.advance

            result = {
                :success => true,
                :picks => [@pick],
                :balance => {
                    :balance => @team.balance.to_f,
                    :salary_total => @team.salary_total.to_f
                }
            }
            format.json { render :json => result }
        end
    end

    protected
    def collection
        @picks = @league.draft.picks
    end

    private
    def get_team!
        @team = Team.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
    end
end

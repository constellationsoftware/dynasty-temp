class League::TeamsController < SubdomainController
    before_filter :authenticate_user!, :get_team!

    respond_to :json, :html
    defaults :resource_class => UserTeam, :collection_name => 'teams', :instance_name => 'team'
    custom_actions :resource => [:autopick]

    def index
        index! do |format|
            result = {
                :success => true,
                :teams => @teams
            }
            format.json { render :text => result.to_json(
                :except => [:league_id, :uuid],
                :include => {
                    :picks => {:except => [:draft_id]}
                }
            ) }
        end
    end

    def autopick
        if params[:autopick]
            @team.autopick = true
            @team.save!
            render :text => 'success'
        else
            raise 'Request or parameters invalid!'
        end
    end

    protected
        def collection
            if (!!params[:page] and !!params[:limit])
                @teams = end_of_association_chain.page(params[:page]).per(params[:limit])
            else
                @teams = end_of_association_chain
            end
            @teams = @teams.joins { league }.where { league.id == my { @league.id } }
            @total = @teams.size
        end

    private
        def get_team!
            @team = UserTeam.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
        end
end

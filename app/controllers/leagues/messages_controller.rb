class Leagues::MessagesController < SubdomainController
    before_filter :authenticate_user!, :get_team!

    def send
        clients = JuggernautClient.find_all_by_league_id(@league.id)
        channels = clients.collect{ |client| "/observer/#{client.uuid}" }
        if channels.size > 0
            Juggernaut.publish(channels, {
                :id => nil,
                :type => :create,
                :class => 'ShoutboxMessages',
                :record => {
                    :user => @team.name,
                    :message => params[:message],
                    :timestamp => DateTime::now,
                    :type => :text
                }
            })
        end
        render :nothing => true
    end

    private
        def get_team!
            @team = Team.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
        end
end

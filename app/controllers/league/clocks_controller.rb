class League::ClocksController < SubdomainController
    custom_actions :resource => [ :next_week, :reset ]
    respond_to :html, :json

    def next_week
        next_week! do |format|
            @clock.next_week
            #publish_update
        end
    end

    def reset
        reset! do |format|
            @clock.reset
            #publish_update
        end
    end

    protected
        def resource
            @clock = @league.clock
        end

        def publish_update
            clients = JuggernautClient.find_all_by_league_id(@league.id)
            channels = clients.collect{ |client| "/observer/#{client.uuid}" }
            if channels.size > 0
                Juggernaut.publish(channels, {
                    :type =>   'update',
                    :id =>     @clock.id,
                    :class =>  'Clock',
                    :record => @clock.flatten
                })
            end
        end
end

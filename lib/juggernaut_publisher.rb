class JuggernautPublisher < AbstractController::Base
    include AbstractController::Rendering
    include AbstractController::Helpers
    include AbstractController::Translation
    include Rails.application.routes.url_helpers
    helper ApplicationHelper
    self.view_paths = 'app/views'

    def publish(type, record)
        class_name = record.class.name
        instance_variable_set("@#{class_name.downcase}".to_sym, record) # instance variable for our template

        if record.respond_to? 'leagues'
            leagues = record.leagues
            clients = leagues.inject([]){ |aggregate, league| aggregate += JuggernautClient.find_all_by_league_id(league.id) }
        elsif record.respond_to? 'league'
            clients = JuggernautClient.find_all_by_league_id(record.league.id)
        else
            clients = JuggernautClient.all
        end
        channels = clients.collect{ |client| "/observer/#{client.uuid}" }

        unless channels.empty?
            Juggernaut.publish(channels, {
                :type =>   type,
                :id =>     record.id,
                :class =>  record.class.name,
                :record => self.render(template: "/push/#{class_name.underscore}/#{type}")
            })
        end
    end
end

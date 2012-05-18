class JuggernautPublisher < AbstractController::Base
    include AbstractController::Rendering
    include AbstractController::Helpers
    include AbstractController::Translation
    include Rails.application.routes.url_helpers
    helper ApplicationHelper
    self.view_paths = 'app/views'

    # TODO: Figure out where we want push to occur and structure subscriptions accordingly
    ##
    # Pushes data profiled as an "event" (think in terms of javascript).
    # If a template is supplied, it will pass the
    #
    def event(channels, event, data = nil)
        Juggernaut.publish channels, { :type => 'event', :event => event, :data => data } unless channels.empty?
    end

    def alert(channels, event, message, level = 'alert')
        Juggernaut.publish channels, { :type => 'alert', :event => event, :data => { :level => level, :message => message } } unless channels.empty?
    end

    # TODO: figure out why the JSON string coming back from a render doesn't have commas or array brackets. It's not parseable
    def record(channels, event, record, &block)
        payload = block ? yield(self, record) : render(record)
        Juggernaut.publish channels, { :type => 'event', :event => event, :data => payload } unless channels.empty?
    end

    def publish
=begin
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
=end
    end
end

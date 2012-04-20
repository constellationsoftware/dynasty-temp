class JuggernautClient < SuperModel::Base
    include SuperModel::Redis::Model
    include SuperModel::Timestamp::Model

    belongs_to :team
    validates_presence_of :team_id

    attributes :session_count
    indexes :team_id, :uuid, :league_id

    def session_count
        read_attribute(:session_count) || 0
    end

    #
    # Socket Subscription Stuff
    #
    # Clients connect on a per-team basis instead of per-user because it makes common league-wide events easier to fire
    # for all the clients in that league. When a user subscribes to an event, their session count is incremented.
    # Similarly, it is decremented on disconnection with the socket.
    #
    def self.subscribe
        Juggernaut.subscribe do |event, data|
            puts "Subscription request params: #{data.inspect}"
            data.default = {}
            uuid = data['meta']['id']
            next unless uuid

            case event
            when :subscribe
                event_subscribe(uuid)
            when :unsubscribe
                event_unsubscribe(uuid)
            end
        end
    end

    def self.event_subscribe(uuid)
        client = find_by_uuid(uuid)
        unless client
            # get team id from UUID
            team = Team.find_by_uuid(uuid)
            client = self.new({ :team_id => team.id, :uuid => uuid, :league_id => team.league_id })
        end
        client.increment!
        puts "Client(id: #{client.team_id}) session count: #{client.session_count}"
    end

    def self.event_unsubscribe(team_id)
        client = find_by_team_id(team_id)
        client && client.decrement!
    end

    def increment!
        self.session_count += 1
        save!
    end

    def decrement!
        self.session_count -= 1
        self.session_count > 0 ? save! : destroy
    end
end

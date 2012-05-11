module Pusher
    class Job
        include Singleton

        DEFAULT_USER_ID = 0
        attr_accessor :socket

        def initialize
            # create the socket and start the connection process
            #PusherClient.logger = Logger.new(STDOUT)
            @socket = PusherClient::Socket.new(Pusher.key, {:secret => Pusher.secret})
            @socket.connect(true)

            @socket.bind('pusher_internal:member_added') do |result|
                data = parse(result)
                team = get_team_from_data(data) if data
                if !(team.nil?) and team.is_a? Team
                    team.is_online = true
                    team.save()
                end
            end

            @socket.bind('pusher_internal:member_removed') do |result|
                data = parse(result)
                team = get_team_from_data(data) if data
                if !(team.nil?) and team.is_a? Team
                    team.is_online = false
                    team.save()
                end
            end

            @socket.bind('pusher:error') do |result|
                raise result
            end

            # subscribe to all active drafts
            drafts = Draft.joins{ league }.includes{ league }
            drafts.each do |draft|
                channel_name = Draft::CHANNEL_PREFIX + draft.league.slug
                @socket.subscribe(channel_name, DEFAULT_USER_ID)
            end

            loop do
                sleep(1) # Keep main thread running
            end
        end

        def error(job, exception)
            puts exception.to_json
        end

        def parse(s)
            begin
                ActiveSupport::JSON.decode(s)
            rescue Exception => e
                PusherClient.logger.warn("Attempt to parse Pusher data (#{s.inspect}) threw an exception: #{e.message}")
            end
        end

        def get_team_from_data(data)
            begin
                Team.find_by_uuid(data['user_id'].to_s) unless data['user_id'] == 0
            rescue Exception => e
                PusherClient.logger.warn("Unexpected data format for data: #{data.inspect}. Expected a 'user_id' key; can not continue.")
            end
        end
    end
end

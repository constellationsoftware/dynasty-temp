require 'pusher-client'

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
                team = get_team_from_data(parse(result))
                if !(team.nil?) and team.is_a? UserTeam
                    team.is_online = true
                    team.save()
                end
            end

            @socket.bind('pusher_internal:member_removed') do |result|
                team = get_team_from_data(parse(result))
                if !(team.nil?) and team.is_a? UserTeam
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
        end

        handle_asynchronously :initialize

        def error(job, exception)
            puts exception.to_json
        end

        def parse(s)
            begin
                return ActiveSupport::JSON.decode(s)
            rescue => err
                PusherClient.logger.warn(err)
                PusherClient.logger.warn("Pusher : data attribute not valid JSON")
                return s
            end
        end

        def get_team_from_data(data)
            begin
                if data['user_id'] == 0
                    return nil
                else
                    return UserTeam.find_by_uuid(data['user_id'].to_s)
                end
            rescue => err
                PusherClient.logger.warn(err)
                PusherClient.logger.warn('Unexpected data format for team. Can not continue.')
            end
        end
    end
end

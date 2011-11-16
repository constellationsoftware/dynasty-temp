require 'pusher-client'

module Pusher
	class Job
		include Singleton

		DEFAULT_USER_ID = 0
		attr_accessor :socket

		def initialize
			# create the socket and start the connection process
			PusherClient.logger = Logger.new(STDOUT)
			self.socket = PusherClient::Socket.new(Pusher.key, { :secret => Pusher.secret })
			self.socket.connect(true)

			# Bind to a global event (can occur on either channel1 or channel2)
			self.socket.bind('globalevent') do |data|
				puts "GLOBAL EVENT!"
			  puts data
			end

			self.socket.bind('pusher_internal:member_added') do |result|
				# ignore anything from the default user id

				data = parse(result)
				on_member_join(data) #unless data[:user_id] != DEFAULT_USER_ID
			end

			self.socket.bind('pusher_internal:member_removed') do |result|
				# ignore anything from the default user id

				data = parse(result)
				on_member_leave(data) #unless data[:user_id] != DEFAULT_USER_ID
			end

			# subscribe to all active drafts
			Draft.active.each do |draft|
				channel_name = 'presence-draft-' + draft.id.to_s
				self.socket.subscribe(channel_name, DEFAULT_USER_ID)
			end

			loop do
			  sleep(1) # Keep your main thread running
			end
		end
		handle_asynchronously :initialize

		def error(job, exception)
			puts exception.to_json
		end

		def parse(s)
      begin
        return JSON.parse(s)
      rescue => err
        PusherClient.logger.warn(err)
        PusherClient.logger.warn("Pusher : data attribute not valid JSON - you may wish to implement your own Pusher::Client.parser")
        return s
      end
  	end


		protected
			def on_member_join(data)
				team_id = data['team_id']
				team = UserTeam.find(team_id)
				team.is_online = true
				team.save()
				puts "MEMBER JOINED: " + data['user_info']['name'].to_s
			end

			def on_member_leave(data)
				team_id = data['team_id']
				team = UserTeam.find(team_id)
				team.is_online = false
				team.save()

				puts "MEMBER JOINED: " + data['user_info']['name'].to_s
			end
	end
end

require 'pusher-client'

module Pusher
	class Job
		include Singleton

		DEFAULT_USER_ID = 0
		attr_accessor :socket

		def initialize
			# create the socket and start the connection process
			#PusherClient.logger = Logger.new(STDOUT)
			self.socket = PusherClient::Socket.new(Pusher.key, { :secret => Pusher.secret })
			self.socket.connect(true)

			self.socket.bind('pusher_internal:member_added') do |result|
				# ignore anything from the default user id
				data = parse(result)
				puts data.to_json
				on_member_join(data) #unless data[:user_id] != DEFAULT_USER_ID
			end

			self.socket.bind('pusher_internal:member_removed') do |result|
				# ignore anything from the default user id

				data = parse(result)
				puts data.to_json
				on_member_leave(data) #unless data[:user_id] != DEFAULT_USER_ID
			end

			# subscribe to all active drafts
			drafts = Draft.active.find(:all, :include => :league)
			drafts.each do |draft|
				channel_name = Draft::CHANNEL_PREFIX + draft.league.slug
				self.socket.subscribe(channel_name, DEFAULT_USER_ID)
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
				uuid = data['user_info']['team_id'].to_s
				team = UserTeam.find_by_uuid(uuid)
				team.is_online = true
				team.save()
				#puts "MEMBER JOINED: " + data['user_info']['name'].to_s
			end

			def on_member_leave(data)
				uuid = data['user_info']['team_id'].to_s
				team = UserTeam.find_by_uuid(uuid)
				team.is_online = false
				team.save()
				#puts "MEMBER JOINED: " + data['user_info']['name'].to_s
			end
	end
end

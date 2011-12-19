require 'delayed_job'

class League::PicksController < SubdomainController
	before_filter :authenticate_user!

	has_scope :draft_data, :type => :boolean, :default => true, :only => :index
	respond_to :json

	def index
		index! do |format|
			result = {
				:success => true,
				:picks => @picks
			}
			format.json { render :text => result.to_json(
        :except => [ :draft_id ],
        :include => {
          :team => { :except => [ :league_id, :uuid ] }
        }
      )}
		end
	end

	def update
		update! do |format|
			# move this somewhere else I guess
			socket_id ||= @pick.team.last_socket_id
			payload = {
				:pick => @pick,
				:next_pick => @pick.draft.get_current_pick
			}
			Pusher[Draft::CHANNEL_PREFIX + @pick.draft.league.slug].delay.trigger('draft:pick:update', payload, socket_id)
			@pick.draft.advance

			result = {
				:success => true,
				:picks => [ @pick ]
			}
			format.json { render :json => result }
		end
	end

	protected
		def collection
			@picks = @league.draft.picks
		end
end

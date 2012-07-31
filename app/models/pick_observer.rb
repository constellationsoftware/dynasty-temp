class PickObserver < ActiveRecord::Observer
    def before_save(pick)
        # if a player was picked, update the timestamp
        pick.picked_at = Time.now unless pick.player.nil?
    end

    def after_update(pick)
        # TODO: assign lineup ID more intelligently i.e. don't stick a player in a flex just because it's available. They might have wanted them on the bench
        # create PlayerTeam (lineup will be assigned procedurally for the moment)
        player_team = PlayerTeam.create!({ :team_id => pick.team_id, :player_id => pick.player_id }, :without_protection => true)
        pickData = pick.attributes
        unless player_team.lineup.nil?
            pickData[:lineup] = {
                :position => player_team.lineup.position.abbreviation.upcase,
                :string => player_team.lineup.string
            }
        end
        payload = {
            :player => { :id => pick.player_id, :name => pick.player.full_name },
            :team => { :id => pick.team.uuid, :name => pick.team.name },
            :pick => pickData
        }
        JuggernautPublisher.new.event pick.team.league.channels, 'draft:picked', payload# unless (self.online.count === 0 or force_finish)

        pick.draft.picked!
=begin
        record = PlayerTeam.create do |ptr|
            ptr.current = TRUE
            ptr.player_id = pick.player_id
            ptr.details = "Drafted in round #{pick.round} at #{pick.picked_at} by #{pick.team.name}"
            ptr.team_id = pick.team_id
            ptr.added_at = pick.picked_at
            ptr.depth = 0
            ptr.position_id = pick.player.position.id
        end
        # attempt to bump them to a starter position so it'll run the validation
        record.depth = 1
        record.save

        # finish the draft if there are no picks remaining
        finished = Pick.joins { draft }.where { (draft_id == my { pick.draft_id }) & (isnull(player_id)) }.count === 0
        if finished
            pick.draft.status = :finished
            pick.draft.finished_at = Time.now
            pick.draft.current_pick_id = nil
            pick.draft.save

            # reset all teams' autopick status to false
            pick.draft.teams.each { |team|
                team.autopick = false
                team.save
            }
        end
=end
    end
end

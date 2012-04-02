class PickObserver < ActiveRecord::Observer
    def before_save(pick)
        # if a player was picked, update the timestamp
        if !!pick.player
            pick.picked_at = Time.now
        end
    end

    def after_update(pick)
        record = PlayerTeamRecord.create do |ptr|
            ptr.current = TRUE
            ptr.player_id = pick.player_id
            ptr.details = "Drafted in round #{pick.round} at #{pick.picked_at} by #{pick.team.name}"
            ptr.user_team_id = pick.team_id
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
    end
end

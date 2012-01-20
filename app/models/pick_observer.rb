class PickObserver < ActiveRecord::Observer
    def before_save(pick)
        # if a player was picked, update the timestamp
        if !!pick.player
            pick.picked_at = Time.now
        end
    end

    def after_update(pick)
        intended_depth = 0
        my_designation = pick.player.position.designation
        my_depth = 1

        # total possible slots for this designation and any position
        slots = Player.free_slots()[my_depth][my_designation].to_i
        position_counts = Player.get_position_counts(pick.team, my_depth, my_designation)
        # compute the total filled slots for this designation
        counts = position_counts.collect{ |x| x.count if x.designation == my_designation }.compact
        player_sum = counts.empty? ? 0 : counts.reduce(:+)

        # number of filled slots for this position and designation and total
        position_count = position_counts.find do |x|
            x.abbreviation == pick.player.position.abbreviation
        end
        position_count = position_count.count unless position_count.nil?
        position_max_count = Player.position_quantities()[my_depth][(my_designation).to_sym][(pick.player.position.abbreviation).to_sym]

        #puts "sum: #{player_sum}, slots: #{slots}, pos_count: #{position_count}, max: #{position_max_count}"
        intended_depth = 1 if player_sum < slots && (position_max_count.nil? || position_count < position_max_count)

        puts intended_depth

        # create PlayerTeam record based on pick data
        record = PlayerTeamRecord.create do |ptr|
            ptr.current = TRUE
            ptr.player_id = pick.player_id
            ptr.details = "Drafted in round #{pick.round} at #{pick.picked_at} by #{pick.team.name}"
            ptr.user_team_id = pick.team_id
            ptr.league_id = pick.team.league.id
            ptr.added_at = pick.picked_at
            ptr.depth = intended_depth
            ptr.position_id = pick.player.position.id
        end

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

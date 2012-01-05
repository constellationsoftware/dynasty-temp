class PickObserver < ActiveRecord::Observer
  def before_save(pick)
    # if a player was picked, update the timestamp
    if !!pick.player
      pick.picked_at = Time.now
    end
  end

  def after_update(pick)
    finished_count = Pick.joins{draft}.where{draft.id.eq pick.draft.id}.maximum(:pick_order)

    if pick.pick_order === finished_count
      pick.draft.status = :finished
      pick.draft.finished_at = Time.now
      pick.draft.current_pick_id = nil
      pick.draft.save
    end

    ptr = PlayerTeamRecord.new
    ptr.current = TRUE
    ptr.player_id = pick.player_id
    ptr.details = "Drafted in round #{pick.round}"
    ptr.user_team_id = pick.team_id
    ptr.added_at = pick.picked_at
    ptr.save
  end
end

class PickObserver < ActiveRecord::Observer
  def before_save(pick)
    # if a player was picked, update the timestamp
    if !!pick.player
      pick.picked_at = Time.now
    end
  end

  def after_update(pick)
    finished = Pick.joins{draft}
      .where{(draft_id == my{pick.draft_id}) & (isnull(player_id))}
      .count === 0

    if finished
      pick.draft.status = :finished
      pick.draft.finished_at = Time.now
      pick.draft.current_pick_id = nil
      pick.draft.save

      # TODO: Edit this to update after each pick is made not at end of draft.
      PlayerTeamRecord.match_picks(pick.draft)
    end
  end
end

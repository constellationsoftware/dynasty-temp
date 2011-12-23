class PickObserver < ActiveRecord::Observer
  def before_save(pick)
    # if a player was picked, update the timestamp
    if !!pick.player
      pick.picked_at = Time.now

      #audit the team's balance now
      #picks = pick.team.picks
    end
  end

  def after_update(pick)
    finished_count = Pick.joins{draft}.where{draft.id == pick.draft.id}.maximum(:pick_order)

    if pick.pick_order === finished_count
      pick.draft.status = :finished
      pick.draft.finished_at = Time.now
      pick.draft.save
    end
  end
end

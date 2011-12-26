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
      puts "THE DRAFT IS DONE!"
      pick.draft.status = :finished
      pick.draft.finished_at = Time.now
      pick.draft.current_pick_id = nil
      pick.draft.save
    end
  end
end

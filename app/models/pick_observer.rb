class PickObserver < ActiveRecord::Observer
  def after_create(model)
    round = model.round
    draft = model.round.draft

    finished_count = draft.league.user_teams.count
    picks_count= Pick.where(:round_id => round.id).count

    if picks_count == finished_count
      round.finished = true
      round.save
    end
    rounds_count = Round.count(:conditions => {
                                 :draft_id => draft.id,
                                 :finished => true
                               })
    if rounds_count == draft.number_of_rounds
      draft.finished = true
      draft.save
    end
  end
end

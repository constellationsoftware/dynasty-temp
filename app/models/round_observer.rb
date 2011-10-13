class RoundObserver < ActiveRecord::Observer
  def after_create(model)
    if model.draft.rounds.count.odd?
      position = 1
    else
      position = model.league.user_teams.count
    end
    model.league.user_teams.each do |user_team|
      model.picking_orders.create(:user_team => user_team, :position => position)
      if model.draft.rounds.count.odd?
        position += 1
      else
        position -= 1
      end
    end
    if model.picking_orders.empty? then
      model.errors.add(:picking_orders, "There are no available user_teams for this round")
      raise ActiveRecord::Rollback if model.picking_orders.empty?
    end

    model.picking_orders.freeze
  end
end

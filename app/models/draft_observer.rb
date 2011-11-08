class DraftObserver < ActiveRecord::Observer
  def after_create(model)
    i = 1
    number_of_teams = model.league.teams.count
    draft_id = model.id
    league_id = model.league_id
    round = 0

    model.number_of_rounds.times do
        round += 1
        model.league.teams.each(:order => "id ASC") do |team|
            @pick = Pick.new
            @pick.draft_id = draft_id
            @pick.team_id = team.id
            @pick.pick_order = i
            @pick.save!
        end
    end
  end
end



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
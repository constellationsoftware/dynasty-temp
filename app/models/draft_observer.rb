class DraftObserver < ActiveRecord::Observer
  def after_save(model)
    i = 0
    number_of_teams = model.league.teams.count
    model.number_of_rounds.times do
        model.league.teams.each do |team|
            i += 1
            @pick = Pick.new
            @pick.draft_id = model.id
            @pick.team_id = team.id
            @pick.pick_order = i
            @pick.save!
        end
    end
  end
end



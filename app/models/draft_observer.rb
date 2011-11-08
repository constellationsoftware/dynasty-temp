class DraftObserver < ActiveRecord::Observer
  def after_create(model)
    model.number_of_rounds.times do
        model.league.teams.each do |team|
            team.picks.create
        end
    end
  end
end

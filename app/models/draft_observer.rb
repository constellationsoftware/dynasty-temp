class DraftObserver < ActiveRecord::Observer
<<<<<<< HEAD
 def after_save(model)
  
 end
=======
=begin
  def after_save(model)
    i = 0
    round = 0
    teams = model.league.teams

    model.number_of_rounds.times do
        round += 1
        if round.odd?
            roundsort = teams.sort
        else
            roundsort = teams.sort.reverse
        end
        roundsort.each do |team|
            i += 1
            @pick = Pick.new
            @pick.draft_id = model.id
            @pick.team_id = team.id
            @pick.pick_order = i
            @pick.save!
        end
    end
  end
=end
>>>>>>> 21a744f33b4f69fe41d4c7fdf9936e3961419b46
end



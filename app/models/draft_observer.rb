class DraftObserver < ActiveRecord::Observer
    def after_create(draft)
        # generate picks for draft
        teams = draft.league.teams.sort
        teams_reverse = teams.reverse

        rounds = Lineup.count
        rounds.times do |round|
            t = round.even? ? teams : teams_reverse
            t.each_with_index do |team, i|
                Pick.create :draft_id => draft.id,
                    :team_id => team.id,
                    :pick_order => (i + 1) + (teams.size * round),
                    :round => round + 1
            end
        end

        # apply league trophy fee
        trophy_event = Events::PayTrophyFee.create!
        trophy_event.process draft.league
    end
end




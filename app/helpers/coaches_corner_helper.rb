module CoachesCornerHelper
    def game_review_tab_class(game, team)
        classes = []
        if game.scored?
            classes << (game.won?(team) ? 'won' : 'lost')
        end
        classes
    end
end

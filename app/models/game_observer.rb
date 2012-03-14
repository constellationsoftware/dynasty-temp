class GameObserver < ActiveRecord::Observer
    def after_create(game)
        game.team.balance += Settings.game.winning_payout
    end
end

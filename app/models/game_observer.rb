class GameObserver < ActiveRecord::Observer
    def before_update(game)
        if game.scored?
            home_team = game.home_team
            away_team = game.away_team

            home_payout = (game.won?(home_team) ? Settings.game.winning_payout : Settings.game.losing_payout).to_money
            away_payout = (game.won?(away_team) ? Settings.game.winning_payout : Settings.game.losing_payout).to_money

            # assign the winnings by creating a new transaction
            home_transaction = Account.new :amount => home_payout, :eventable => game, :receivable => home_team, :payable => game.league
            away_transaction = Account.new :amount => away_payout, :eventable => game, :receivable => away_team, :payable => game.league
            if home_transaction.save! && away_transaction.save!
                home_team.balance += home_payout
                game.league.balance -= home_payout
                pay_players home_team, game
                home_team.save!

                away_team.balance += away_payout
                game.league.balance -= away_payout
                pay_players away_team, game
                away_team.save!

                game.league.save!
            end
        end
    end

    def pay_players(team, game)
        team.player_team.each do |player_team|
            player_payment = (player_team.player.contract.amount / Settings.season_weeks).to_money
            if Account.create! :amount => player_payment, :eventable => game, :receivable => player_team, :payable => team
                team.balance -= player_payment
            end
        end
    end
end

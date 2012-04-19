# == Schema Information
#
# Table name: dynasty_events
#
#  id           :integer(4)      not null, primary key
#  type         :string(255)
#  source_id    :integer(4)
#  source_type  :string(255)
#  target_id    :integer(4)
#  target_type  :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  processed_at :datetime
#

class Events::PayGameWinnings < Events::Base
    belongs_to :game, :foreign_key => :source_id, :foreign_type => :source_type
    has_many :transactions, :as => :event

    def process(game)
        process! do
            if game.scored?
                home_team = game.home_team
                away_team = game.away_team

                home_payout = (game.won?(home_team) ? Settings.game.winning_payout : Settings.game.losing_payout).to_money
                away_payout = (game.won?(away_team) ? Settings.game.winning_payout : Settings.game.losing_payout).to_money

                # assign the winnings by creating a new transaction
                home_team.balance += home_payout
                game.league.balance -= home_payout
                home_transaction = Account.new :amount => home_payout,
                    :event => self,
                    :receivable => home_team,
                    :receivable_balance => home_team.balance,
                    :payable => game.league,
                    :payable_balance => game.league.balance

                away_team.balance += away_payout
                game.league.balance -= away_payout
                away_transaction = Account.new :amount => away_payout,
                    :event => self,
                    :receivable => away_team,
                    :receivable_balance => away_team.balance,
                    :payable => game.league,
                    :payable_balance => game.league.balance

                if home_transaction.save! && away_transaction.save!
                    home_team.save!
                    away_team.save!
                    game.league.save!
                end
            end
        end
    end
end

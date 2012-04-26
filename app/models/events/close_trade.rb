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

class Events::CloseTrade < Events::Base
    belongs_to :trade, :foreign_key => :target_id, :foreign_type => :target_type
    has_many :transactions, :as => :event

    def process(trade)
        process! do
            team1 = trade.initial_team
            team2 = trade.second_team
            league = team1.league

            # swap player_team team IDs
            pt1 = PlayerTeam.find_by_id(trade.offered_player_id)
            pt2 = PlayerTeam.find_by_id(trade.requested_player_id)
            tmp = pt2.team_id
            pt2.team_id = pt1.team_id
            pt2.lineup_id = nil
            pt1.team_id = tmp
            pt1.lineup_id = nil
            if pt1.save! && pt2.save!
                collect_trade_fees(team1, league, pt1.player.contract.amount)
                collect_trade_fees(team2, league, pt2.player.contract.amount)
            end
        end
    end

    protected
        def collect_trade_fees(team, league, trade_value)
            fee = (trade_value.to_f * Settings.trade.fee_percentage / 100).to_money

            # half the fee goes to the league
            team.balance -= (fee / 2)
            league.balance += (fee / 2)
            fee_to_league = Account.new :amount => (fee / 2),
                :event => self,
                :receivable => league,
                :receivable_balance => league.balance,
                :payable => team.league,
                :payable_balance => team.balance
            # other half to the fed
            team.balance -= (fee / 2)
            fee_to_fed = Account.new :amount => (fee / 2),
                :event => self,
                :payable => team.league,
                :payable_balance => team.balance
            if fee_to_league.save! && fee_to_fed.save!
                team.save!
                league.save!
            end
        end
end

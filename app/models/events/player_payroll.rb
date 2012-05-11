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

class Events::PlayerPayroll < Events::Base
    has_many :transactions, :as => :event

    def process(team)
        process! do
            team.player_teams.each do |player_team|
                player_payment = (player_team.player.contract.amount / Settings.season_weeks).to_money
                resulting_balance = team.balance -= player_payment
                if PlayerAccount.create! :event => self,
                    :amount => player_payment,
                    :receivable => player_team,
                    :payable => team,
                    :payable_balance => resulting_balance
                    team.balance = resulting_balance
                    team.save!
                end
            end
        end
    end
end

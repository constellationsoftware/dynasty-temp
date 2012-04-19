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

class Events::PayGuaranteedSalary < Events::Base
    has_many :transactions, :as => :event

    def process(player_team, team_id)
        process! do
            team = Team.find(team_id)
            player_payment = (player_team.guaranteed_remaining or 0).to_money
            if player_payment > 0.to_money
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

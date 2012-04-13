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

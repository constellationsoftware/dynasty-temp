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

class Events::PayLuxuryTax < Events::Base
    has_many :transactions, :as => :event

    def process(league)
        process! do
            soft_cap = Settings.team.soft_cap.to_money
            payees = []

            luxury_tax_collected = league.teams.inject(0.to_money) do |tax, team|
                total_payroll = team.player_teams.inject(0.to_money){ |cumulative_payroll, player_team| cumulative_payroll + player_team.player_contract.amount.to_money }
                if !(total_payroll.nil?) && total_payroll > soft_cap
                    luxury_tax_payment = (total_payroll - soft_cap) * Settings.team.luxury_tax_percentage / 100
                    team.balance -= luxury_tax_payment
                    if Account.create! :event => self,
                        :amount => luxury_tax_payment,
                        :payable => team,
                        :payable_balance => team.balance
                        team.save!
                    end

                    tax += luxury_tax_payment
                else
                    payees << team
                end
                tax
            end

            # divide the cumulative luxury tax collected among the teams under the soft cap
            unless luxury_tax_collected === 0 || payees.empty?
                luxury_tax_relief = luxury_tax_collected / payees.size
                payees.each do |payee|
                    payee.balance += luxury_tax_relief
                    if Account.create! :event => self,
                        :amount => luxury_tax_relief,
                        :receivable => payee,
                        :receivable_balance => payee.balance
                        payee.save!
                    end
                end
            end
        end
    end
end

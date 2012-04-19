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

class Events::PayTrophyFee < Events::Base
    has_many :transactions, :as => :event

    def process(league)
        process! do
            trophy_fee = Settings.league.trophy_fee.to_money
            resulting_balance = league.balance -= trophy_fee
            if LeagueAccount.create! :event => self,
                :amount => trophy_fee,
                :payable => league,
                :payable_balance => resulting_balance

                league.balance = resulting_balance
                league.save!
            end
        end
    end
end

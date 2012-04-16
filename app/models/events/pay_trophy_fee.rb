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

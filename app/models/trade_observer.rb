class TradeObserver < ActiveRecord::Observer
    def before_create(trade)
        trade.offered_at = Time.now
        trade.open = 1
        trade.accepted = 0
    end

    def before_update(trade)
        # trade is closing
        if trade.open === 0
            if trade.accepted_was === 0 && trade.accepted === 1 # trade succeeded
                trade_event = Events::CloseTrade.create!
                trade_event.process trade
            else # trade rejected or retracted

            end
        end
    end
end

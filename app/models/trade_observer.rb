class TradeObserver < ActiveRecord::Observer
    def before_create(trade)
        trade.offered_at = Time.now
        trade.open = 1
        trade.accepted = 0
    end

    def before_update(trade)
        if trade.open
        else # trade is closing
            if trade.accepted && !trade.accepted_was # trade succeeded
                trade_event = Events::CloseTrade.create!
                trade_event.process trade
            else # trade rejected or retracted

            end
        end
    end
end

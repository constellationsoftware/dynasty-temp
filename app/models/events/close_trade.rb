class Events::CloseTrade < Events::Base
    belongs_to :trade, :foreign_key => :target_id, :foreign_type => :target_type

    def process(trade)
        process! do
            # calculate guaranteed salary for the players
        end
    end
end

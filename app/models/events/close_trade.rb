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

    def process(trade)
        process! do
            # calculate guaranteed salary for the players
        end
    end
end

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
    has_many :transactions, :as => :event
    def process(trade)
        process! do



          @team1 = trade.initial_team
          @player1 = trade.offered_player
          @tax1 = trade.offered_player.salary / Settings.trade.fee_percentage

          @team2 = trade.second_team
          @trade2 = trade.requested_player
          @tax2 = trade.requested_player.salary / Settings.trade.fee_percentage

          @transaction1 = Account.new :amount => @tax1
              :event => self,
              :receivable_balance => tax1,
              :payable => @team1,
              :payable_balance => @tax1

          @transaction2 = Account.new :amount => @tax2
            :event => self,
            :receivable_balance => @tax2,
            :payable => @team2,
            :payable_balance => @tax2


          if transaction1.save! && transaction2.save!
            @team1.save!
            @team2.save!

          end







        end
    end
end

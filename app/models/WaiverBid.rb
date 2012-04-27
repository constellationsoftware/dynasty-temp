class WaiverBid < ActiveRecord::Base
  self.table_name = 'dynasty_waiver_bids'

  belongs_to :waiver
  belongs_to :team



end

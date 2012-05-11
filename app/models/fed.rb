class Fed < ActiveRecord::Base
    self.table_name = 'dynasty_fed'

    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable
end

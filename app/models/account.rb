class Account < ActiveRecord::Base
    self.table_name = 'dynasty_accounts'
    money :amount, :cents => :amount_cents

    belongs_to :payable, :polymorphic => true
    belongs_to :receivable, :polymorphic => true
    belongs_to :eventable, :polymorphic => true
end

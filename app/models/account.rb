class Account < ActiveRecord::Base
    self.table_name = 'dynasty_accounts'

    money :amount, :cents => :amount_cents
    money :payable_balance, :cents => :payable_balance_cents
    money :receivable_balance, :cents => :receivable_balance_cents

    belongs_to :payable, :polymorphic => true
    belongs_to :receivable, :polymorphic => true
    belongs_to :event, :class_name => 'Events::Base', :polymorphic => true

    validates_with Validators::Account

    scope :transactions_this_season, lambda{
        season = Season.current
        where{ transaction_datetime >> (season.start_date.to_time..season.end_date.to_time) }
    }
end

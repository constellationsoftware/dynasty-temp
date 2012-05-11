# == Schema Information
#
# Table name: dynasty_accounts
#
#  id              :integer(4)      not null, primary key
#  type            :string(255)
#  payable_id      :integer(4)
#  payable_type    :string(255)
#  receivable_id   :integer(4)
#  receivable_type :string(255)
#  eventable_id    :integer(4)      not null
#  eventable_type  :string(255)     not null
#  amount_cents    :integer(8)      not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

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


  def balance(team)
    if receivable_id == team.id
      balance = receivable_balance_cents
    end

    if payable_id == team.id
      balance = payable_balance_cents
    end

    balance
  end

end

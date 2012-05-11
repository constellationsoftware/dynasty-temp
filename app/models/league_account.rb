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

class LeagueAccount < Account
end

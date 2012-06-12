# == Schema Information
#
# Table name: dynasty_user_addresses
#
#  id          :integer(4)      not null, primary key
#  ship_city   :string(50)
#  street2     :string(64)
#  ship_state  :string(32)
#  city        :string(50)
#  ship_zip    :string(10)
#  zip         :string(10)
#  state       :string(32)
#  country     :string(64)
#  street      :string(128)
#  user_id     :integer(4)      not null
#  ship_street :string(64)
#

class UserAddress < ActiveRecord::Base
    self.table_name = 'dynasty_user_addresses'

    belongs_to :user, :inverse_of => :address, :touch => true
    attr_accessible :street, :street2, :city, :zip, :state, :country

    validates_presence_of :street, :city, :state, :zip, :country
end

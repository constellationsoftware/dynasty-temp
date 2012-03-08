class UserAddress < ActiveRecord::Base
    self.table_name = 'dynasty_user_addresses'

    belongs_to :user, :inverse_of => :address, :touch => true
    attr_accessible :street, :street2, :city, :zip, :state, :country

    #validates_presence_of :street, :city, :state, :zip, :country
end

# == Schema Information
#
# Table name: sports_property
#
#  id                   :integer(4)      not null, primary key
#  sports_property_type :string(100)
#  sports_property_id   :integer(4)
#  formal_name          :string(100)     not null
#  value                :string(255)
#

class SportsProperty < ActiveRecord::Base
    self.table_name = "sports_property"
end

# == Schema Information
#
# Table name: addresses
#
#  id            :integer(4)      not null, primary key
#  location_id   :integer(4)      not null
#  language      :string(100)
#  suite         :string(100)
#  floor         :string(100)
#  building      :string(100)
#  street_number :string(100)
#  street_prefix :string(100)
#  street        :string(100)
#  street_suffix :string(100)
#  neighborhood  :string(100)
#  district      :string(100)
#  locality      :string(100)
#  county        :string(100)
#  region        :string(100)
#  postal_code   :string(100)
#  country       :string(100)
#

class Address < ActiveRecord::Base
    belongs_to :location
end

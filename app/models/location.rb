# == Schema Information
#
# Table name: locations
#
#  id           :integer(4)      not null, primary key
#  city         :string(100)
#  state        :string(100)
#  area         :string(100)
#  country      :string(100)
#  timezone     :string(100)
#  latitude     :string(100)
#  longitude    :string(100)
#  country_code :string(100)
#

class Location < ActiveRecord::Base
    has_one :address

    has_one :display_name,
            :foreign_key => 'entity_id',
            :conditions => ['entity_type = ?', 'locations']
end

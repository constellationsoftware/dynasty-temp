# == Schema Information
#
# Table name: sites
#
#  id           :integer(4)      not null, primary key
#  site_key     :string(128)     not null
#  publisher_id :integer(4)      not null
#  location_id  :integer(4)
#

class Site < ActiveRecord::Base
    belongs_to :location
    belongs_to :publisher
end

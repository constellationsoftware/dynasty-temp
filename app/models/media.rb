# == Schema Information
#
# Table name: media
#
#  id                   :integer(4)      not null, primary key
#  object_id            :integer(4)
#  source_id            :integer(4)
#  revision_id          :integer(4)
#  media_type           :string(100)
#  publisher_id         :integer(4)      not null
#  date_time            :string(100)
#  credit_id            :integer(4)      not null
#  db_loading_date_time :datetime
#  creation_location_id :integer(4)      not null
#

class Media < ActiveRecord::Base
    has_and_belongs_to_many :events
    has_and_belongs_to_many :persons
    has_and_belongs_to_many :teams, :class_name => 'SportsDb::Team'
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  person_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base

    belongs_to :person


end

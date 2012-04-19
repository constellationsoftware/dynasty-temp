# == Schema Information
#
# Table name: wagering_straight_spread_lines
#
#  id                 :integer(4)      not null, primary key
#  bookmaker_id       :integer(4)      not null
#  event_id           :integer(4)      not null
#  date_time          :datetime
#  team_id            :integer(4)      not null
#  person_id          :integer(4)
#  rotation_key       :string(100)
#  comment            :string(255)
#  vigorish           :string(100)
#  line_value         :string(100)
#  line_value_opening :string(100)
#  prediction         :string(100)
#

class WageringStraightSpreadLine < ActiveRecord::Base
end

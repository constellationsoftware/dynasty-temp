# == Schema Information
#
# Table name: wagering_total_score_lines
#
#  id            :integer(4)      not null, primary key
#  bookmaker_id  :integer(4)      not null
#  event_id      :integer(4)      not null
#  date_time     :datetime
#  team_id       :integer(4)      not null
#  person_id     :integer(4)
#  rotation_key  :string(100)
#  comment       :string(255)
#  vigorish      :string(100)
#  line_over     :string(100)
#  line_under    :string(100)
#  total         :string(100)
#  total_opening :string(100)
#  prediction    :string(100)
#

class WageringTotalScoreLine < ActiveRecord::Base
end

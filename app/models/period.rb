# == Schema Information
#
# Table name: periods
#
#  id                   :integer(4)      not null, primary key
#  participant_event_id :integer(4)      not null
#  period_value         :string(100)
#  score                :string(100)
#  score_attempts       :integer(4)
#  rank                 :string(100)
#  sub_score_key        :string(100)
#  sub_score_type       :string(100)
#  sub_score_name       :string(100)
#

class Period < ActiveRecord::Base
    belongs_to :participants_event

end

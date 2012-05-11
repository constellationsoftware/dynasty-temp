# == Schema Information
#
# Table name: affiliation_phases
#
#  id                      :integer(4)      not null, primary key
#  affiliation_id          :integer(4)      not null
#  root_id                 :integer(4)
#  ancestor_affiliation_id :integer(4)
#  start_season_id         :integer(4)
#  start_date_time         :datetime
#  end_season_id           :integer(4)
#  end_date_time           :datetime
#

class AffiliationPhase < ActiveRecord::Base
    belongs_to :affiliation
    has_many :descendants, :class_name => "AffiliationPhase",
             :foreign_key => "ancestor_affiliation_id"
    belongs_to :ancestor_affiliation, :class_name => "AffiliationPhase"
end

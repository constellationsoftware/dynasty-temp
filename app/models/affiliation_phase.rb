class AffiliationPhase < ActiveRecord::Base
    belongs_to :affiliation
    has_many :descendants, :class_name => "AffiliationPhase",
             :foreign_key => "ancestor_affiliation_id"
    belongs_to :ancestor_affiliation, :class_name => "AffiliationPhase"
end

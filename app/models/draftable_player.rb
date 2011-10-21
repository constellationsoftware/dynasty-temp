class DraftablePlayer < ActiveRecord::Base
	has_many :person_scores, :foreign_key => "person_id"

end

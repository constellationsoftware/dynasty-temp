class DraftablePlayer < ActiveRecord::Base
	set_table_name "persons"
	has_many :person_scores, :foreign_key => "person_id"

end
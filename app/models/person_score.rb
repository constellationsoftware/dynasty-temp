class PersonScore < ActiveRecord::Base
  belongs_to :person
  belongs_to :draftable_player, :primary_key => "person_id"
end

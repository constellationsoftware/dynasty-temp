class PersonPhase < ActiveRecord::Base
  is_polymorphic_as_table
  belongs_to :person
  belongs_to :membership, :polymorphic => true
  belongs_to :position, :foreign_key => "regular_position_id"
  belongs_to :role
  belongs_to :season, :foreign_key => "end_season_id"
  belongs_to :season, :foreign_key => "start_season_id"
end

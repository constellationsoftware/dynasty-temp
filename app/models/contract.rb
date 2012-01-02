class Contract < ActiveRecord::Base
  set_table_name 'dynasty_player_contracts'

  belongs_to :player, :foreign_key => 'person_id'
end

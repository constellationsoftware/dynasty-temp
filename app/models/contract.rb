class Contract < ActiveRecord::Base
  set_table_name 'dynasty_player_contracts'
  belongs_to :person
end

class PlayerPoint < ActiveRecord::Base
  set_table_name 'dynasty_player_points'
  belongs_to :player
  default_scope :order => 'year DESC'
end

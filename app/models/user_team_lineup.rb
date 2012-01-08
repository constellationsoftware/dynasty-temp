class UserTeamLineup < ActiveRecord::Base
  belongs_to :qb, :foreign_key => :qb_id, :class_name => 'PlayerTeamRecord'
  belongs_to :k, :foreign_key => :k_id, :class_name => 'PlayerTeamRecord'
  belongs_to :wr1, :foreign_key => :wr1_id, :class_name => 'PlayerTeamRecord'
  belongs_to :wr2, :foreign_key => :wr2_id, :class_name => 'PlayerTeamRecord'
  belongs_to :rb1, :foreign_key => :rb1_id, :class_name => 'PlayerTeamRecord'
  belongs_to :rb2, :foreign_key => :rb2_id, :class_name => 'PlayerTeamRecord'
  belongs_to :te, :foreign_key => :te_id, :class_name => 'PlayerTeamRecord'

  belongs_to :user_team
  has_many :players, :through => :player_team_records
end

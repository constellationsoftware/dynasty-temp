class Game < ActiveRecord::Base
    self.table_name = 'dynasty_games'
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => 'team_id'
    has_many :transactions, :as => :eventable, :class_name => 'Account'
    belongs_to :league
end

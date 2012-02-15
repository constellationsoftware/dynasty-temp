class Schedule < ActiveRecord::Base
    self.table_name = 'dynasty_user_team_schedules'
    belongs_to :team, :inverse_of => :schedules, :foreign_key => 'team_id', :class_name => 'UserTeam'
    belongs_to :opponent, :class_name => 'UserTeam', :foreign_key => 'opponent_id'

    default_scope order{week}
    scope :for_week, lambda {|x| where{week == my{x}}}
    scope :with_opponent, joins{opponent}.includes{opponent}

    def self.ratio(games)
        if games.respond_to?('each')
            wins = losses = 0
            games.each do |game|
                unless game.outcome.nil?
                    game.outcome === 1 ? wins += 1 : losses += 1
                end
            end
            { :wins => wins, :losses => losses }
        end
    end
end

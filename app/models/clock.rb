# == Schema Information
#
# Table name: dynasty_clock
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  time       :datetime
#

class Clock < ActiveRecord::Base
    self.table_name = 'dynasty_clock'

    def next_week
        7.times do |i|
            self.time = self.time.advance :days => 1
            self.save!
        end
        JuggernautPublisher.new.publish(:update, self)
    end

    def reset
        self.time = Season.current.start_date.at_midnight
        JuggernautPublisher.new.publish(:update, self) if self.save!
    end

    def present
        self.time = Time.now
        self.save!
        self.time
    end

    def nice_time
        self.time.strftime("%B %e, %Y")
    end

    def week
        season = Season.current
        ((self.time.to_date - season.start_date) / 7).to_i
    end

    def flatten
        {
            :id => self.id,
            :time => self.time,
            :date_short => self.nice_time,
            :week => self.week
        }
    end

    def weeks_since(clock_start)
        ((self.time.to_date - clock_start.to_date) / 7).to_i
    end

    def self.first_week
        return Date.new(2011, 9, 8).at_midnight
    end

    def is_team_payday?; days_to_pay_teams === 0 end
    def days_to_pay_teams
        self.time.days_to_week_start(Settings.team_pay_day.to_sym)
    end

    def is_player_payday?; days_to_pay_players === 0 end
    def days_to_pay_players
        self.time.days_to_week_start(Settings.player_pay_day.to_sym)
    end

    def season_ended?(season)
        self.time > season.end_date.to_time
    end
end

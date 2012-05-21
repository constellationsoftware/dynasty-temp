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
    TZ = 'Eastern Time (US & Canada)'

    def next_week
        7.times do |i|
            self.time = self.time.advance :days => 1
            self.save!
        end
        #JuggernautPublisher.new.publish(:update, self)
    end

    def reset
        self.time = Season.current.start_date.at_midnight
        self.save!
        #JuggernautPublisher.new.publish(:update, self) if self.save!
    end

    def present
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

    def weeks_since(clock_start)
        ((self.time.to_date - clock_start.to_date) / 7).to_i
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

    def time
        time = super
        time.in_time_zone self.class::TZ
    end

    def time=(t)
        super t.in_time_zone self.class::TZ
    end
end

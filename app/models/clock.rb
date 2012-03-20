class Clock < ActiveRecord::Base
    self.table_name = 'dynasty_clocks'

    has_many :leagues

    def next_week
        self.time = self.time.advance(:days => 7)
        self.time if save

=begin
        PlayerTeamRecord.all.each do |ptr|
            pth = PlayerTeamHistory.new
            pth.player_id = ptr.player_id
            pth.user_team_id = ptr.user_team_id
            pth.week = self.week
            pth.depth = ptr.depth
            pth.league_id = ptr.league_id
            pth.position_id = ptr.position_id
            pth.save!
        end
=end
    end

    def reset
        self.time = Season.current.at_midnight
        self.save!
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
end

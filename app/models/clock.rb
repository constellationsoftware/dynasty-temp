class Clock < ActiveRecord::Base
    self.table_name = 'dynasty_clocks'

    has_many :leagues

    def next_week
        self.time = self.time.advance(:days => 7)
        self.save!
        self.time

        ## do payroll
        UserTeam.with_players.each do |team|
            my_season_payroll = team.players.to_a.sum(&:amount)
            my_weekly_payroll = 0
            if team.schedules.count > 0
                my_weekly_payroll = my_season_payroll / team.schedules.count
            end


            team.balance = team.balance - my_weekly_payroll.to_money
            #team.balance = team.balance + team.games.last.winnings

            #TODO Figure out why negative money values gives an error...
            team.balance = "0" if team.balance < 0.to_money
            team.save

            # create historical records
        end

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
    end

    def reset
        self.time = Date.new(2011, 9, 8).at_midnight
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
        beginning = Date.new(2011, 9, 8).at_midnight
        ((self.time.to_date - beginning.to_date) / 7).to_i
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

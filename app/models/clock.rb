class Clock < ActiveRecord::Base
    def next_week
        self.time = self.time.advance(:days => 7)
        self.save!
        self.time
        
        ## do payroll
        UserTeam.all.each do |team|
          my_season_payroll = team.players.to_a.sum(&:amount)
          puts team.balance
          puts "-"
          my_weekly_payroll = my_season_payroll / team.schedules.count
          puts my_weekly_payroll
          team.balance = team.balance - my_weekly_payroll.to_money

          #TODO Figure out why negative money values gives an error...
          team.balance = "0" if team.balance < 0.to_money
          puts "balance:"
          puts team.balance
          team.save
        end

    end

    def reset
        self.time = Date.new(2011, 9, 8).at_midnight
        self.save!
        self.time

        Game.all.each { |game| game.destroy }
        Schedule.all.each do |s|
            s.outcome = nil
            s.team_score = nil
            s.opponent_score = nil
            s.updated_at = nil
            s.save
        end
    end

    def present
        self.time = Time.now
        self.save!
        self.time
    end

    def nice_time
        self.time.strftime("%B %e, %Y")
    end

    def weekly_points_for_team(team)
        week_end = self.time
        week_start = self.time.advance :weeks => -1

        PlayerEventPoint.select { sum(points).as('points') }.joins { [event, player.team_link.team] }.where { player.team_link.team.id == my { team.id } }.where { player.team_link.depth == 1 }.where { (event.start_date_time >= week_start) & (event.start_date_time < week_end) }.first.points
    end

    def week
        beginning = Date.new(2011, 9, 8).at_midnight
        week = ((self.time.to_date - beginning.to_date) / 7).to_i
        week
    end



    def calculate_points_for_league(league)
        puts self.time
        puts league.inspect
        beginning = Date.new(2011, 9, 8).at_midnight
        
        league.teams.each { |team|
            points = weekly_points_for_team(team)
            #week = ((self.time.to_date - beginning.to_date) / 7).to_i + 1
            #puts "points: #{points} week: #{week}"
            Game.create :team_id => team.id, :week => self.week, :points => (points ? points : 0)
        }
    end
end

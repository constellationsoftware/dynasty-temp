class Clock < ActiveRecord::Base
    def next_week
        self.time = self.time.advance(:days => 7)
        self.save!
        self.time

        ## do payroll
        UserTeam.all.each do |team|
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

            pth.save
            puts pth.player.name.full_name
            puts "saved"
        end


        ## save historical starters lineup
=begin
        UserTeam.all.each do |team|
            if team.user_team_lineups.first
                current_lineup = team.user_team_lineups.current.first
                @nl = team.user_team_lineups.create
                @nl.qb_id = current_lineup.qb_id
                @nl.wr1_id = current_lineup.wr1_id
                @nl.wr2_id = current_lineup.wr2_id
                @nl.rb1_id = current_lineup.rb1_id
                @nl.rb2_id = current_lineup.rb2_id
                @nl.te_id = current_lineup.te_id
                @nl.k_id = current_lineup.k_id
                @nl.current = 0
                @nl.week = Clock.find(2).week
                @nl.save
            end
        end
=end
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
        UserTeamLineup.historical.all.each {|lineup| lineup.destroy}
        UserTeam.all.each do |t|
            t.balance = 75000000
            t.save
        end
        PlayerTeamHistory.all.each {|pth| pth.destroy}
        Trade.all.each {|trade| trade.destroy}
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

        starter_points = PlayerEventPoint.select{sum(points).as('points')}
            .joins{[event, player.team_link.team]}
            .where{player.team_link.team.id == my{ team.id }}
            .where{player.team_link.depth == 1}
            .where{(event.start_date_time >= week_start) & (event.start_date_time < week_end)}
            .first.points
        bench_points = PlayerEventPoint.select{sum(points).as('points')}
            .joins{[event, player.team_link.team]}
            .where{player.team_link.team.id == my{ team.id }}
            .where{player.team_link.depth == 0}
            .where{(event.start_date_time >= week_start) & (event.start_date_time < week_end)}
            .first.points
        starter_points.to_f + (bench_points.to_f / 3)
    end

    def week
        beginning = Date.new(2011, 9, 8).at_midnight
        ((self.time.to_date - beginning.to_date) / 7).to_i
    end

    def calculate_points_for_league(league)
        league.teams.each { |team|
            points = weekly_points_for_team(team)
            #week = ((self.time.to_date - beginning.to_date) / 7).to_i + 1
            #puts "points: #{points} week: #{week}"
            Game.create :team_id => team.id, :week => self.week, :points => (points ? points : 0)
        }
    end

    def self.first_week
        return Date.new(2011, 9, 8).at_midnight
    end
end

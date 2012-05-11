class GameScheduler
    include Singleton

    def initialize
        # load scheduling data
        file = File.join(Rails.root, 'lib', 'assets', 'schedule.yml')
        @schedule_data = YAML::load(File.open(file))
    end

    def schedule(teams)
        season = Season.current
        @schedule_data.each_with_index do |week, i|
            week.each do |matchup|
                # create game record
                match = parse_matchup(matchup)
                home_team = teams[match[1].to_i - 1]
                away_team = teams[match[2].to_i - 1]
                Game.create :league_id => home_team.league_id,
                    :date => season.start_date.advance(:weeks => i),
                    :home_team_id => home_team.id,
                    :away_team_id => away_team.id
            end
        end
    end

    private
        ##
        # Parse accepts the following formats in any combination:
        # team0 at team1
        # team 0 @ team 1
        # Team #0 at Team #1
        # Team0 @ Team1
        # ...etc.
        def parse_matchup(matchup)
            /team(?:[ #]+)?([\d]{1,2}) ?(?:at|@) ?team(?:[ #]+)?([\d]{1,2})/i.match matchup
        end
end

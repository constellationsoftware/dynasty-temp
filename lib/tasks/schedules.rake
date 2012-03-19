namespace :dynasty do
    namespace :data do
        namespace :generate do
            desc 'Generates scheduling plans for leagues'
            task :schedules => [:environment] do
                schedule_configs = {}

                leagues = League.joins{ drafts }.where{ drafts.status == :finished }
                leagues.each do |league|
                    # randomize team order
                    #teams = league.teams.sample(league.teams.size)
                    unless schedule_configs.has_key? league.teams.size.to_s
                        schedule_configs[league.teams.size.to_s] = load_schedule_config(league.teams.size)
                    end
                    schedule_configs[league.teams.size.to_s].each_with_index do |week, i|
                        week.each do |match_str|
                            # create game record
                            match = parse_matchup(match_str)
                            home_team = league.teams[match[1].to_i - 1]
                            away_team = league.teams[match[2].to_i - 1]
                            Game.create :league_id => league.id,
                                :week => i + 1,
                                :home_team_id => home_team.id,
                                :away_team_id => away_team.id
                        end
                    end
                end
            end

            def load_schedule_config(team_size)
                file = File.join(Rails.root, 'lib', 'assets', 'schedules', "#{team_size}teams.yml")
                YAML::load(File.open(file))
            end

            def parse_matchup(matchup)
                /team(?:[ #]+)?([\d]{1,2}) ?(?:at|@) ?team(?:[ #]+)?([\d]{1,2})/i.match matchup
            end
        end
    end
end

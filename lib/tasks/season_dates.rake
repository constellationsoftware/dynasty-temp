namespace :dynasty do
    namespace :data do
        namespace :generate do
            desc 'Sets the season start and end dates from a config file on the seasons table'
            task :season_dates => [:environment] do
                file = File.join(Rails.root, 'lib', 'assets', 'season_dates.yml')
                sports = YAML::load(File.open(file))
                sports.each_pair do |sport, years|
                    years.each_pair do |year, dates|
                        start_date = dates[0]
                        end_date = dates[1]
                        season = Season.where{ (start_date_time == nil) | (end_date_time == nil) }
                            .where{ season_key == year }
                            .first

                        season.start = start_date.at_midnight if start_date
                        season.end = end_date.at_midnight if end_date
                        season.save
                    end
                end
            end
        end
    end
end

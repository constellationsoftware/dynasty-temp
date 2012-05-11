namespace :dynasty do
    namespace :data do
        namespace :generate do
            desc 'Sets the season start and end dates from a config file on the seasons table'
            task :seasons => [:environment] do
                file = File.join(Rails.root, 'lib', 'assets', 'season_dates.yml')
                sports = YAML::load(File.open(file))
                sports.each_pair do |affiliate, years|
                    years.each_pair do |my_year, data|
                        start_date = data['start']
                        end_date = data.has_key?('end') ? data['end'] : nil
                        Season.where{ (affiliation == my{ affiliate }) && (year == my_year) }.first_or_create!(
                            :affiliation => affiliate,
                            :year => my_year,
                            :current => data.has_key?('current') ? data['current'] : false,
                            :start_date => start_date,
                            :end_date => end_date,
                            :weeks => (start_date && end_date) ? ((end_date - start_date) / 7).to_i : 0
                        )
                    end
                end
            end
        end
    end
end

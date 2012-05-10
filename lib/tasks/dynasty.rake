# Kind of a catch-all task namespace for this project

namespace :dynasty do
    namespace :data do
        namespace :generate do
            desc "Normalizes player positions in the 'positions' table to those in lib/assets/team_names.yml"
            task :positions => [:environment] do
                values = []
                puts 'Emptying player <=> link table!'
                ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerPosition.table_name}")

                puts 'Emptying positions table!'
                ActiveRecord::Base.connection.execute("TRUNCATE #{Position.table_name}")

                positions_file = File.join(Rails.root, 'lib', 'assets', 'positions.yml')
                valid_positions = YAML::load(File.open(positions_file))
                valid_positions.each_with_index do |data, index|
                    # create or find the normalized position record
                    position = Position.create do |u|
                        u.name = data['name']
                        u.abbreviation = data['abbreviation']
                        u.sort_order = index + 1
                        u.designation = data['designation']
                        u.flex = data['flex'].to_i if data.has_key?('flex')
                    end
                    aliases = data.has_key?('aliases') ? data['aliases'] : []
                    valid_position_values = [ data['abbreviation'], data['name'].parameterize ]
                    valid_position_values += aliases.collect { |item| item.parameterize }

                    players = Person.select{ distinct(id) }.joins{ positions }.where{ substring_index(substring_index(positions.abbreviation, ',', 1), '/', 1).in valid_position_values }.where{ (person_phases.membership_type == 'teams') & (person_phases.phase_status == 'active') }
                    puts "Collecting records for #{position.name.pluralize}"

                    # make the link
                    players.each do |player|
                        values << "(#{player['id']},#{position.id})"
                    end
                end

                puts 'Writing to the database...'
                ActiveRecord::Base.connection.execute("
                    INSERT INTO #{PlayerPosition.table_name}(player_id, position_id) VALUES #{values.join(',')}
                ")
                ActiveRecord::Base.connection.execute("
                    UPDATE dynasty_player_teams pt
                    JOIN dynasty_player_positions lnk ON pt.player_id = lnk.player_id
                    SET pt.position_id = lnk.position_id
                    WHERE pt.position_id != lnk.position_id
                ")
            end


            desc 'Calculates season point totals for all players'
            task :points => [:environment] do
                puts 'Emptying player points table!'
                ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerPoint.table_name}")

                seasons = Season.order{ season_key.desc }
                seasons.each do |season|

                    year = season.season_key

                    players = Person.joins{ stats }.calculate_points_from_season(year.to_i)
                    players.each do |player|
                        # zero out points per player
                        fumbles_points = 0
                        defensive_points = 0
                        passing_points = 0
                        rushing_points = 0
                        sacks_against_points = 0
                        special_teams_points = 0
                        scoring_points = 0
                        games_played = 0
                        # this breaks points down per stat repository type
                        player.stats.each do |stat|
                            repo_type = stat.stat_repository_type
                            case repo_type
                                when "american_football_defensive_stats"
                                    defensive_points += stat.stat_repository.points
                                when "american_football_fumbles_stats"
                                    fumbles_points += stat.stat_repository.points
                                when "american_football_passing_stats"
                                    passing_points += stat.stat_repository.points
                                when "american_football_rushing_stats"
                                    rushing_points += stat.stat_repository.points
                                when "american_football_sacks_against_stats"
                                    sacks_against_points += stat.stat_repository.points
                                when "american_football_special_teams_stats"
                                    special_teams_points += stat.stat_repository.points
                                when "american_football_scoring_stats"
                                    scoring_points += stat.stat_repository.points
                                when "core_stats"
                                    games_played += stat.stat_repository.events_played.to_i
                                else
                            end
                        end
                        # this provides the total sum points
                        points = player.stats.collect { |stat| stat.points }.compact.sum
                        point_data = []
                        point_data << "(#{points},#{player.id},#{year},#{defensive_points},#{fumbles_points},#{passing_points},#{rushing_points},#{sacks_against_points},#{scoring_points},#{special_teams_points},#{games_played})"

                        puts "Writing point totals for player id: #{player.id} #{year}..."
                        ActiveRecord::Base.connection.execute(
                            "INSERT INTO #{PlayerPoint.table_name}(points, player_id, year, defensive_points, fumbles_points, passing_points, rushing_points, sacks_against_points, scoring_points, special_teams_points, games_played) VALUES #{point_data.join(',')}"
                        )
                    end
                end
            end


            desc 'Adds regular position depth to player contracts from person phases'
            task :add_position_depth => [:environment] do
                Contract.all.each do |c|
                    c.depth = c.person.person_phases.where(:membership_type => 'teams').andand.first.andand.regular_position_depth
                    if c.depth == 'starter'
                        c.depth = '1'
                    end
                    c.save
                end
            end


            desc 'Records player event point dates'
            task :event_points_dates => [:environment] do
                PlayerEventPoint.all.each do |pep|
                    pep.event_date = pep.event.start_date_time
                    pep.save
                end
            end


            desc 'Generate initial autopicks'
            task :auto_picks => [:environment] do
                Team.all.each do |team|
                    i = 0
                    Player.with_points_from_season.limit{ 500 }.order{ points.desc }.each do |player|
                        i += 1
                        favorite = Favorite.new
                        favorite.team_id = team.id
                        favorite.player_id = player.id
                        favorite.sort_order = i
                        favorite.save
                    end
                end
            end


            desc 'Calculates event point totals for all players'
            task :event_points => [:environment] do
                puts 'Emptying player events points table!'
                ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerEventPoint.table_name}")

                players = Person.all
                players.each_with_index do |player, i|
                    point_data = []

                    player.events.each do |event|
                        fumbles_points = 0
                        defensive_points = 0
                        passing_points = 0
                        rushing_points = 0
                        sacks_against_points = 0
                        special_teams_points = 0
                        scoring_points = 0

                        stats = player.event_stats.where(:stat_coverage_id => event.id)
                        stats.each do |stat|
                            repo_type = stat.stat_repository_type
                            case repo_type
                                when "american_football_defensive_stats"
                                    defensive_points = stat.stat_repository.points
                                when "american_football_fumbles_stats"
                                    fumbles_points = stat.stat_repository.points
                                when "american_football_passing_stats"
                                    passing_points = stat.stat_repository.points
                                when "american_football_rushing_stats"
                                    rushing_points = stat.stat_repository.points
                                when "american_football_sacks_against_stats"
                                    sacks_against_points = stat.stat_repository.points
                                when "american_football_sacks_against_stats"
                                    sacks_against_points = stat.stat_repository.points
                                when "american_football_special_teams_stats"
                                    special_teams_points = stat.stat_repository.points
                                when "american_football_scoring_stats"
                                    scoring_points = stat.stat_repository.points
                                when "core_stats"

                                else

                            end
                        end

                        metadata = PersonEventMetadata.find_by_person_id_and_event_id(player.id, event.id)
                        # this provides the total sum points
                        points = stats.collect { |stat| stat.points }.compact.sum
                        point_data << "(#{points}, #{player.id}, #{event.id}, '#{event.start_date_time.to_datetime}', #{metadata.nil? ? nil : metadata.id}, #{defensive_points}, #{fumbles_points}, #{passing_points}, #{rushing_points}, #{sacks_against_points},#{scoring_points},#{special_teams_points}, '#{Time.now}', '#{Time.now}')"
                    end

                    if point_data.empty?
                        puts "No point records found for player id: #{player.id} (#{i + 1}/#{players.size})"
                    else
                        puts "Writing point totals for player id: #{player.id} (#{i + 1}/#{players.size})"
                        ActiveRecord::Base.connection.execute(
                            "INSERT INTO #{PlayerEventPoint.table_name}(points, player_id, event_id, event_date, metadata_id, defensive_points, fumbles_points, passing_points, rushing_points, sacks_against_points, scoring_points, special_teams_points, created_at, updated_at) VALUES #{point_data.join(',')}"
                        )
                    end
                end
            end


            desc 'Sets player bye weeks from lib/assets/bye_weeks.yml'
            task :bye_weeks => [:environment] do
                db = ActiveRecord::Base.connection
                file = File.join(Rails.root, 'lib', 'assets', 'bye_weeks.yml')
                bye_weeks = YAML::load(File.open(file))
                bye_weeks.each do |week, teams|
                    query = <<EOS
                        SELECT pp.person_id AS player_id
                        FROM person_phases pp
                        JOIN teams t ON pp.membership_type = 'teams'
                            AND pp.membership_id = t.id
                            AND t.team_key LIKE '%nfl%'
                        JOIN display_names n ON n.entity_type = 'teams'
                            AND n.entity_id = t.id
                        WHERE pp.phase_status != 'inactive'
                            AND n.last_name IN ("#{teams.join('","')}")
EOS
                    result = db.execute query
                    result.each do |player_id|
                        contract = Contract.find_by_person_id(player_id)
                        begin
                            contract.bye_week = week.to_i
                            contract.save
                        rescue Exception => msg
                            puts msg
                            puts "Player with ID '#{player_id}' does not have a contract record!" if contract.nil?
                        end
                    end
                end
            end
        end
    end
end

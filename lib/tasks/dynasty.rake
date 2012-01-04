# Kind of a catch-all task namespace for this project

namespace :dynasty do
  namespace :data do
    namespace :generate do
      desc "Normalizes player positions in the 'positions' table to those in lib/assets/team_names.yml"
      task :positions => [:environment] do
        values = []
        puts 'Emptying player <=> link table!'
        ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerPosition.table_name}")

        positions_file = File.join(Rails.root, 'lib', 'assets', 'positions.yml')
        valid_positions = YAML::load(File.open(positions_file))
        valid_positions.each do |abbr, data|
          # create or find the normalized position record
          position_name = (data.kind_of? String) ? data : data['name']
          position = Position.find_or_create_by_name(position_name) { |u| u.abbreviation = abbr }
          aliases = (data.kind_of? Hash) ? data['aliases'] : []
          valid_position_values = []
          valid_position_values << abbr
          valid_position_values << position_name.parameterize
          valid_position_values += aliases.collect{ |item| item.parameterize }

          players = Person.select{distinct(id)}
            .joins{positions}
            .where{substring_index(substring_index(positions.abbreviation, ',', 1), '/', 1).in valid_position_values}
            .where{(person_phases.membership_type == 'teams') & (person_phases.phase_status == 'active')}
          puts "Collecting records for #{position.name.pluralize}"

          # make the link
          players.each do |player|
            values << "(#{player['id']},#{position.id})"
          end
        end

        puts 'Writing to the database...'
        ActiveRecord::Base.connection.execute(
          "INSERT INTO #{PlayerPosition.table_name}(player_id, position_id) VALUES #{values.join(',')}"
        )
      end

      desc 'Calculates season point totals for all players'
      task :points => [ :environment ] do
        puts 'Emptying player points table!'
        ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerPoint.table_name}")
        
        seasons = Season.order{season_key.desc}
        seasons.each do |season|

          year = season.season_key

          players = Person.joins{stats}.calculate_points_from_season(year.to_i)
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
                  defensive_points += stat.stat_repository.points.to_i
                when "american_football_fumbles_stats"
                  fumbles_points += stat.stat_repository.points.to_i
                when "american_football_passing_stats"
                  passing_points += stat.stat_repository.points.to_i
                when "american_football_rushing_stats"
                  rushing_points += stat.stat_repository.points.to_i
                when "american_football_sacks_against_stats"
                  sacks_against_points += stat.stat_repository.points.to_i
                when "american_football_special_teams_stats"
                  special_teams_points += stat.stat_repository.points.to_i
                when "american_football_scoring_stats"
                  scoring_points += stat.stat_repository.points.to_i
                when "core_stats"
                  games_played += stat.stat_repository.events_played.to_i
                else
               end
            end
            # this provides the total sum points
            points = player.stats.collect{ |stat| stat.points }.compact.sum
            point_data = []
            point_data << "(#{points},#{player.id},#{year},#{defensive_points},#{fumbles_points},#{passing_points},#{rushing_points},#{sacks_against_points},#{scoring_points},#{special_teams_points},#{games_played})"

            puts "Writing point totals for player id: #{player.id} #{year}..."
            ActiveRecord::Base.connection.execute(
                "INSERT INTO #{PlayerPoint.table_name}(points, player_id, year, defensive_points, fumbles_points, passing_points, rushing_points, sacks_against_points, scoring_points, special_teams_points, games_played) VALUES #{point_data.join(',')}"
            )
          end
        end
      end
      desc 'Calculates event point totals for all players'
      task :event_points => [ :environment ] do
        puts 'Emptying player events points table!'
        ActiveRecord::Base.connection.execute("TRUNCATE #{PlayerEventPoint.table_name}")

        Person.all.each do |player|
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
            # this provides the total sum points
            points = stats.collect{ |stat| stat.points }.compact.sum
            point_data = []
            point_data << "(#{points},#{player.id},#{event.id}, #{defensive_points}, #{fumbles_points}, #{passing_points}, #{rushing_points}, #{sacks_against_points},#{scoring_points},#{special_teams_points})"

            puts "Writing point totals for player id: #{player.id} #{event.id}..."
            ActiveRecord::Base.connection.execute(
                "INSERT INTO #{PlayerEventPoint.table_name}(points, player_id, event_id, defensive_points, fumbles_points, passing_points, rushing_points, sacks_against_points, scoring_points, special_teams_points) VALUES #{point_data.join(',')}"
            )
          end
        end
      end
    end
  end
end

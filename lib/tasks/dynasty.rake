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
          point_data = []
          year = season.season_key

          players = Person.joins{stats}.calculate_points_from_season(year.to_i)
          players.each do |player|
            points = player.stats.collect{ |stat| stat.points }.compact.sum
            point_data << "(#{points},#{player.id},#{year})"
          end
          puts "Writing point totals for #{year}..."
          ActiveRecord::Base.connection.execute(
            "INSERT INTO #{PlayerPoint.table_name}(points, player_id, year) VALUES #{point_data.join(',')}"
          )
        end
      end
    end
  end
end

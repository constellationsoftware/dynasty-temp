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

      desc 'Calculates last season points for all players'
      task :points => [ :environment ] do
        players = Person.joins{stats}.with_points_from_season('last')
        players.each do |player|
          points = player.stats.collect{ |stat| stat.points }.compact.sum
          point_record = PlayerPoint.find_or_create_by_player_id(player.id) { |u| u.points = points }
        end
      end
    end
  end
end

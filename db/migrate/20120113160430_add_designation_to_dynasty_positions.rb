class AddDesignationToDynastyPositions < ActiveRecord::Migration
    def up
        change_column :dynasty_positions, :name, :string, { :length => 32 }
        change_column :dynasty_positions, :abbreviation, :string, { :length => 2 }
        add_column :dynasty_positions, :designation, :string, { :length => 1, :null => false }
        add_column :dynasty_positions, :sort_order, :integer

        add_index :dynasty_positions, :name
        add_index :dynasty_positions, :abbreviation
        add_index :dynasty_positions, [ :sort_order, :id, :designation, :abbreviation, :name ], { :name => 'index_dynasty_positions_on_sort_id_des_abbr_name' }
        add_index :dynasty_positions, [ :abbreviation, :id, :designation, :name, :sort_order ], { :name => 'index_dynasty_positions_on_abbr_id_des_name_sort' }
        add_index :dynasty_positions, [ :sort_order, :id ]

        positions_file = File.join(Rails.root, 'lib', 'assets', 'positions.yml')
        valid_positions = YAML::load(File.open(positions_file))
        i = 1
        valid_positions.each do |abbr, data|
            # create or find the normalized position record
            position_name = (data.kind_of? String) ? data : data['name']
            position = Position.find_by_name(position_name)
            unless position.nil?
                position.designation = data['designation']
                position.sort_order = i
                position.save!
            end
            i += 1
        end
    end

    def down
        remove_column :dynasty_positions, :designation
        remove_column :dynasty_positions, :sort_order

        remove_index :dynasty_positions, :name
        remove_index :dynasty_positions, :abbreviation
        remove_index :dynasty_positions, :designation
        remove_index :dynasty_positions, :sort_order
    end
end

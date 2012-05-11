class AddMetadataIdToDynastyPlayerEventPoints < ActiveRecord::Migration
    def up
        add_column :dynasty_player_event_points, :metadata_id, :integer
        add_index :dynasty_player_event_points, :metadata_id

        # create the link data for the metadata rows in the PlayerEventPoint table
        ActiveRecord::Base.connection.execute(<<EOS
            UPDATE #{PlayerEventPoint.table_name} p
                JOIN #{PersonEventMetadata.table_name} m
                ON p.player_id = m.person_id AND p.event_id = m.event_id
                SET p.metadata_id = m.id
EOS
        )
    end

    def down
        remove_column :dynasty_player_event_points, :metadata_id
    end
end

class RemoveUnnecessaryTables < ActiveRecord::Migration
  def up	
  	drop_table :conferences
  	drop_table :divisions
  	drop_table :document_fixture_events
  	drop_table :document_package_entries
  	drop_table :sports
  	drop_table :sports_properties
  end

  def down
  end
end

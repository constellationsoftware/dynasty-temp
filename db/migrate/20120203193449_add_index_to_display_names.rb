class AddIndexToDisplayNames < ActiveRecord::Migration
  def change
      add_index :display_names, [ :entity_type, :last_name, :first_name ]
  end
end

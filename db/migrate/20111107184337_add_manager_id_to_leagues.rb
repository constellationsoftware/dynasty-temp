class AddManagerIdToLeagues < ActiveRecord::Migration
  def change
  	add_column :leagues, :manager_id, :integer
  	add_index :leagues, :manager_id
  end
end

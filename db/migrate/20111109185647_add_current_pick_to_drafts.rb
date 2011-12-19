class AddCurrentPickToDrafts < ActiveRecord::Migration
  def change
  	add_column :drafts, :current_pick, :integer, { :limit => 2 }
  end
end

class AddStatusToDrafts < ActiveRecord::Migration
  def change
    add_column :drafts, :status, :string
    add_index :drafts, :status
    remove_column :drafts, :started
    remove_column :drafts, :finished
  end
end

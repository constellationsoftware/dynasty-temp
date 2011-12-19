class AddSlugToLeague < ActiveRecord::Migration
  def up
    add_column :leagues, :slug, :string, { :limit => 50, :null => false }
    add_index :leagues, :slug, :unique => true
  end

  def down
    remove_column :leagues, :slug
    remove_index :leagues, :slug
  end
end

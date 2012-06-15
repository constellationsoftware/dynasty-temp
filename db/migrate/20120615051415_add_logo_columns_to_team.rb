class AddLogoColumnsToTeam < ActiveRecord::Migration
  def self.up
    change_table :dynasty_teams do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :dynasty_teams, :logo
  end
end

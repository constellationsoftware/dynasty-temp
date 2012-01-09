class AddAutopickToDynastyTeams < ActiveRecord::Migration
  def change
    add_column :dynasty_teams, :autopick, :boolean, { :default => false }
  end
end

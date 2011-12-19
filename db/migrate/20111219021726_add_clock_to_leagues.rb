class AddClockToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :clock, :datetime
  end
end

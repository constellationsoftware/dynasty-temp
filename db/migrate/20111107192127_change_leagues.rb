class ChangeLeagues < ActiveRecord::Migration
  def change
    change_table :leagues do |t|
      t.timestamps
    end
  end
end

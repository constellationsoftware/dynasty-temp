class AddPickedAtToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :picked_at, :datetime
  end
end

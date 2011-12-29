class CreatePositionGroups < ActiveRecord::Migration
  def change
    create_table :position_groups do |t|
      t.string :name
      t.string :abbreviation
    end
  end
end

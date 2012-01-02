class CreateClocks < ActiveRecord::Migration
  def change
    create_table :clocks do |t|

      t.timestamps
    end
  end
end

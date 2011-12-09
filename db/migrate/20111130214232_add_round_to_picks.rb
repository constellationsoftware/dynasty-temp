class AddRoundToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :round, :integer, { :null => false }
  end
end

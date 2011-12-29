class AddStartDateTimeToStats < ActiveRecord::Migration
  def change
    add_column :stats, :start_date_time, :datetime
  end
end

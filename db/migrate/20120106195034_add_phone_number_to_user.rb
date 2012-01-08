class AddPhoneNumberToUser < ActiveRecord::Migration
  def change
    add_column :dynasty_users, :phone, :integer
  end
end

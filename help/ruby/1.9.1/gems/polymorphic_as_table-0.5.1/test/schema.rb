ActiveRecord::Schema.define(:version => 0) do
  create_table :pictures, :force => true do |t|
    t.string :name
    t.integer :imageable_id
    t.string :imageable_type
    t.timestamps
  end
  create_table :employees, :force => true do |t|
    t.string :name
  end

end

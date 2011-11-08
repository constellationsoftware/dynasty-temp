class CreatePicks < ActiveRecord::Migration
  def up
  	create_table "picks", :force => true do |t|
	    t.integer  "person_id"
	    t.integer  "draft_id",	 :null => false
	    t.integer  "team_id",	 :null => false
	    t.integer  "pick_order", :null => false
	    t.datetime "picked_at"
	  end
  end

  def down
  end
end

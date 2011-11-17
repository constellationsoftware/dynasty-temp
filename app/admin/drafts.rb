ActiveAdmin.register Draft do
  menu :parent => "My Leagues"

  index do 
  	column :id
  	column :league
  	column :started_at
  	column :started 
  	column :current_pick
  	default_actions
  end
end

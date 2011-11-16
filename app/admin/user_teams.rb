ActiveAdmin.register UserTeam do
  menu :parent => "My Leagues"

  index do 
  	column :name
  	column :league
  	column :payroll
  	default_actions
  end
end

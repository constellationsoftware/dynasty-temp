ActiveAdmin.register UserTeam do
  menu :parent => "My Leagues"

  index do 
  	column :name
  	column :league

  	default_actions
  end
  #TODO: Get a handle on formtastic syntax, keep getting it confused with HAML...
  show do
    h3 user_team.name
    h4 "League: " + user_team.league.name
  end

  form do |f|
  	f.inputs "Details" do
	  	f.input :name
  		f.input :league
  		f.input :user
  	end
  	f.buttons
  end
end

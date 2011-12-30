ActiveAdmin.register UserTeam do
  menu :parent => "My Leagues"

  index do 
  	column :name
  	column :league
    column "balance" do |team|
      team.balance_cents
    end
  	default_actions
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

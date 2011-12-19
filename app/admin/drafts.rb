ActiveAdmin.register Draft do
  menu :parent => "My Leagues"

  index do 
  	column :id
  	column :league

  	default_actions
  end

  show do
    h3 draft.league.name

  end

  form do |f|
    f.inputs  do

      f.input :league

    end
    f.buttons
  end
end

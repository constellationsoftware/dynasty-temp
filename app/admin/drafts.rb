ActiveAdmin.register Draft do
    menu :parent => "My Leagues"

    index do
        column :id
        column :league
        column :number_of_rounds
        column :current_pick_id
        default_actions
    end

    show do
        h3 draft.league.name

    end

    form do |f|
        f.inputs do

            f.input :league
            f.input :number_of_rounds
        end
        f.buttons
    end
end

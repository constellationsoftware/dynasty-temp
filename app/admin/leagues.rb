ActiveAdmin.register League do

    index do
      column :id
      column :name
      column :slug
      column :size
      column :created_at
      column :updated_at
      default_actions
    end

    show do
        h3 league.name
        div do
          simple_format league.friendly_id
        end
        panel "Teams" do
            table_for league.teams do
                column "name" do |team|
                    team.name
                end
                column "user" do |team|
                    team.user.name
                end
            end
        end
    end

    menu :label => "Manage Leagues"

    form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :size
        f.input :default_balance
      end
      f.buttons
    end
end

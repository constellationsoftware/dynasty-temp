ActiveAdmin.register User do
    filter :name
    filter :email

    index do
        column :id
        column :email
        column :name
        default_actions
    end

    form do |f|
        f.inputs "Details" do
            f.input :name
            f.input :email
            f.input :role
        end
        f.buttons
    end
end

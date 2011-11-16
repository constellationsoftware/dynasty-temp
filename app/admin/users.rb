ActiveAdmin.register User do
    filter :name
    filter :email

  index do
    column :id
    column :email
    column :name
    default_actions
  end

end

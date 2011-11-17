ActiveAdmin.register Pick do
  
    index do
        column "Player", :player
        column :draft_id
        column :picked_at
        column :pick_order
        column :team
        default_actions
    end
end

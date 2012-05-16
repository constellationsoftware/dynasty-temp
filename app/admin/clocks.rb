ActiveAdmin.register Clock do
   member_action :next_week do
       @clock = Clock.find(params[:id])
       @clock.next_week
   end
   
    menu false
  #index do
  #    column :time
  #    column :next_week_path
  #    column :id
  #end

end

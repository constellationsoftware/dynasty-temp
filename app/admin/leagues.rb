ActiveAdmin.register League do
    show do
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
end

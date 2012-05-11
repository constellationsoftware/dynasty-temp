ActiveAdmin.register Game do
    index do
        column :week
        column :home_team
        column :home_team_score
        column :away_team
        column :away_team_score
        column :league
    end

end

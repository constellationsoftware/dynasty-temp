Fabricator :league do
    balance_cents { Settings.league.capacity * Settings.league.new_team_contribution * 100 }
    teams []
end

Fabricator :league_full, :from => :league do
    teams!(:count => (Settings.league.capacity)) do |league, i|
        team = Fabricate(:team_with_players, :league => league)
        if i === 1
            team.user.add_role 'manager', league
        end
        team
    end
end

Fabricator :league_no_draft, :from => :league do
    teams!(:count => (Settings.league.capacity)) do |league, i|
        team = Fabricate(:team, :league => league)
        if i === 1
            team.user.add_role 'manager', league
        end
        team
    end
end

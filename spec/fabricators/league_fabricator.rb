Fabricator :league do
    name { sequence(:name) { |i| "League #{i + 1}" } }
    teams []
end

Fabricator :league_full, :from => :league do
    teams!(:count => (Settings.league.capacity)) { |league| Fabricate(:team_with_players, :league => league) }
end

Fabricator :league_no_draft, :from => :league do
    teams!(:count => (Settings.league.capacity)) { |league| Fabricate(:team, :league => league) }
end

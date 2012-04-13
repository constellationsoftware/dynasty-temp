Fabricator :league do
    name { sequence(:name) { |i| "League #{i + 1}" } }
    teams []
end

Fabricator :full_league, :from => :league do
    teams!(:count => (Settings.league.capacity)) { |league| Fabricate(:team_with_players, :league => league) }
end

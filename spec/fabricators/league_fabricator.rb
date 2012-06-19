Fabricator :league do
    balance_cents { Settings.league.capacity * Settings.league.new_team_contribution * 100 }
    tier 'all-pro'
    teams []
    after_create do |league|
        # make the first user league manager
        league.teams[0].user.add_role 'manager', league

        # increment team count
        league.teams.each{ League.increment_counter :teams_count, league.id }
    end
end

Fabricator :league_full, :from => :league do
    teams(:count => Settings.league.capacity) { Fabricate(:team_with_players) }
end

Fabricator :league_no_draft, :from => :league do
    teams(:count => Settings.league.capacity) { Fabricate(:team) }
end

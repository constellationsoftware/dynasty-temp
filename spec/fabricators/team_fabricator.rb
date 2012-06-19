Fabricator :team do
    name { Forgery::Name.team_name(true) }
    user
end

Fabricator :team_with_players, :from => :team do
    player_teams(:count => (Lineup.count)) { |team, i|
        lineup = Lineup.with_positions.where{ id == my{ i } }.first
        player = Player.available(team.league.id).recommended(team.id, lineup).first
        Fabricate(:player_team, :team => team, :lineup => lineup, :player => player)
    }
end

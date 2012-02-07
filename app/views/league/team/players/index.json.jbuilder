json.array! @player_teams do |json, player_team|
    json.partial! 'league/team/players/player', :player_team => player_team
end

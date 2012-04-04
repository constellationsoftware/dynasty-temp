json.array! @player_teams do |json, player_team|
    json.partial! 'leagues/team/roster/player', :player_team => player_team
end

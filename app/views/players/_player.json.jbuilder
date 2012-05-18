json.id                     player.id
if player.association(:name).loaded?
    json.name do |json|
        json.first_name     player.name.first_name
        json.last_name      player.name.last_name
        json.full_name      player.name.full_name
    end
end
if player.association(:contract).loaded?
    json.contract do |json|
        json.amount         player.contract.amount
        json.bye_week       player.contract.bye_week
    end
end
if player.association(:position).loaded?
    json.position do |json|
        json.abbreviation   player.position.abbreviation
    end
end
if player.association(:points).loaded?
    json.points do |json|
        json.points         player.points.points
    end
end
if player.association(:favorites).loaded?
    json.favorites do |json|
        json.sort_order     player.favorites.first ? player.favorites.first.sort_order : nil
    end
end
if player.association(:player_teams).loaded? && player.association(:team).loaded?
    json.drafted_team do |json|
        json.depth          player.player_teams.depth
        json.name           player.andand.player_teams.andand.team.andand.name
    end
end

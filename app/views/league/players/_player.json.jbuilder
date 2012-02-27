json.id                     player.id
if current_scopes[:with_name]
    json.name do |json|
        json.first_name     player.name.first_name
        json.last_name      player.name.last_name
        json.full_name      player.name.full_name
    end
end
if current_scopes[:with_contract]
    json.contract do |json|
        json.amount         player.contract.amount
        json.bye_week       player.contract.bye_week
    end
end
if current_scopes[:with_position]
    json.position do |json|
        json.abbreviation   player.position.abbreviation
    end
end
if current_scopes[:with_points]
    json.points do |json|
        json.points         player.points.first.points
    end
end
if current_scopes[:with_favorites]
    json.favorites do |json|
        json.sort_order     player.favorites.first ? player.favorites.first.sort_order : nil
    end
end

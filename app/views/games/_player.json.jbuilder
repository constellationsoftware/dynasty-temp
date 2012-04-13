json.id                 player.id
json.name do |json|
    json.first_name     player.name.first_name
    json.last_name      player.name.last_name
    json.full_name      player.name.full_name
end

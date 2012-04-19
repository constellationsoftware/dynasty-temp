json.players(@players) do |json, player|
  json.extract! player, :id, :first_name, :last_name, :position
end

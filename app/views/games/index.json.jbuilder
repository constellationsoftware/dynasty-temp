json.array! @games do |json, game|
    json.partial! 'game', :game => game
end

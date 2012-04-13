json.array! @games do |json, game|
    json.partial! 'game_context', :game => game, :team => @team # this team is the "context"
end

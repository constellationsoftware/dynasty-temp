json.array! @teams do |json, team|
    json.partial! 'team', :team => team
end

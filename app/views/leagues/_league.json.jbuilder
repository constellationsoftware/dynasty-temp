json.id         league.id
json.name       league.name
json.size       league.size
json.team_count league.team_count
json.public     league.public
if current_scopes[:with_manager]
    json.manager do |json|
        json.full_name league.manager.full_name
    end
end

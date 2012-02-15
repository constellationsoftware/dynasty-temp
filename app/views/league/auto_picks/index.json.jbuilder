json.array! @auto_picks do |json, autopick|
    json.partial! 'league/auto_picks/players', :autopick => autopick
end


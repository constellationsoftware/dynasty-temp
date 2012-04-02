json.array! @auto_picks do |json, autopick|
    json.partial! 'leagues/auto_picks/players', :autopick => autopick
end


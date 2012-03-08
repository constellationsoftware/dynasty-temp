json.leagues @leagues do |json, league|
    json.partial! 'league', :league => league
end
json.total @total if @total

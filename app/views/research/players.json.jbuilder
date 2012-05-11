json.players @players do |json, player|
    json.partial! 'player', :player => player
end
json.sEcho                  params[:sEcho].to_i
json.iTotalRecords          @total
json.iTotalDisplayRecords   @total

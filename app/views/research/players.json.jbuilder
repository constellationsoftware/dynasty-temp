json.players @players do |json, player|
    json.partial! 'player', :player => player
end
json.sEcho                  params[:request_id]
json.iTotalRecords          @total
json.iTotalDisplayRecords   @total

json.id                     autopick.player.id
json.bye_week               autopick.player.contract.bye_week
json.full_name              autopick.player.name.full_name
json.contract_amount        autopick.player.contract.amount
json.position               autopick.player.position.andand.abbreviation.andand.upcase

@last_season = PlayerPoint.select(:points).where(:year => '2011').find_by_player_id(autopick.player.id)
json.points_last_season     @last_season.andand.points
json.sort_order             autopick.sort_order
json.points_per_dollar      (@last_season.andand.points.to_f / autopick.player.contract.amount.to_f) * 1000000



json.id             game.id
json.week           game.week
json.opponent       game.opponent_for(@team).name
json.score          game.score_for @team
json.opponent_score game.score_for(game.opponent_for(@team))
json.outcome        game.won? @team

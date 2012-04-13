class Game extends Spine.Model
    @configure 'Game', 'date', 'week', 'team', 'score', 'opponent', 'opponent_score', 'won'
    @extend Spine.Model.Ajax

    @url: urlFor @name
    formatted_outcome: -> if @outcome then 'Won' else 'Lost'
    @total: ->
        wins = 0
        losses = 0
        @each (game) ->
            if game.outcome?
                if game.outcome == 1
                    ++wins
                else
                    ++losses
        "#{wins} - #{losses}"

window.Game = Game

class Game extends Spine.Model
    @configure 'Game', 'week', 'opponent', 'score', 'opponent_score', 'outcome'
    @extend Spine.Model.Ajax

    @url: '/team/games'
    formatted_outcome: ->
        return 'N/A' unless @outcome?
        return if @outcome == 1 then 'Won' else 'Lost'
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

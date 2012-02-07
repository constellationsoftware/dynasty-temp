class Game extends Spine.Model
    @configure 'Game', 'week', 'opponent', 'score', 'opponent_score'
    @extend Spine.Model.Ajax

    @url: '/team/games'
    outcome: ->
        return 'won' if @score > @opponent_score
        return 'lost' if @score < @opponent_score
        return 'tied'

window.Game = Game

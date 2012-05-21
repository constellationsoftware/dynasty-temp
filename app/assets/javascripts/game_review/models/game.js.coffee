class Game extends Spine.Model
    @configure 'Game', 'id', 'date', 'week', 'home_team', 'home_team_score', 'away_team', 'away_team_score', 'won'
    @extend Spine.Model.Ajax

    @url: '/games'

    opponent: (team) ->
        if @home_team_score >= @away_team_score
            if @won? then @home_team else @away_team
        else
            if @won? then @home_team else @away_team

    scored: ->
        @home_team_score? or @away_team_score?

    @getOutcomeClass: (lineup, opponentLineup) ->
        return 'loss' unless lineup? and lineup.points?
        return 'win' unless opponentLineup? and opponentLineup.points?

        points = parseFloat lineup?.points or -Infinity
        opponentPoints = parseFloat opponentLineup?.points or -Infinity
        return '' if points is opponentPoints
        if points > opponentPoints then 'win' else 'loss'

window.Game = Game

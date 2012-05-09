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
        if lineup?
            return '' if lineup.points is 'N/A' or lineup.points is 'BYE'
            return 'win' if not opponentLineup? or lineup.points > opponentLineup.points
        'loss'

window.Game = Game

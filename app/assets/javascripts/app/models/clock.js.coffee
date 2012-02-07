class Clock extends Spine.Model
    @configure 'Clock', 'date_short'
    @extend Spine.Model.Ajax

    @url: '/clock/2'
    date: -> @date_short

window.Clock = Clock

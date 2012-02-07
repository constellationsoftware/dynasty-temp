class Clock extends Spine.Model
    @configure 'Clock', 'date_short'
    @extend Spine.Model.Ajax

    @url: '/clock'
    date: -> @date_short

window.Clock = Clock

class Clock extends Spine.Model
    @configure 'Clock', 'date_short', 'week'
    @extend Spine.Model.Ajax

    @url: '/clock'
    date: -> @date_short

    update: ->
        super

        console.log('clock updated')
        # fire a global clock update event
        Spine.trigger 'clock:update', @
        #location.reload()
window.Clock = Clock

class Clock extends Spine.Model
    @configure 'Clock', 'date', 'week'
    @extend Spine.Model.Ajax

    # create the clock item if it doesn't exist, that way we don't have to fetch it initially (because we don't care until it changes)
    @update: (id, record) ->
        clock = if @exists(id) then @find id else @create id: id
        super id, record

    update: ->
        super

        # fire a global clock update event
        Spine.trigger 'clock:update', @

window.Clock = Clock

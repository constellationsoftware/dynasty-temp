class Clock extends Spine.Model
    @configure 'Clock', 'time'
    @bind('update', (time) -> alert('The time changed to ' + time))

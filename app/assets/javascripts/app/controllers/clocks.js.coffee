class Clocks extends Spine.Controller
    constructor: ->
        super

        # Bind listeners for clock change, then instantiate the clock
        Clock.bind 'refresh', (items) => @render items[0]
        Clock.bind 'change', @render
        Clock.fetch()

    render: (item) =>
        @html @view('clock')(item)


window.Clocks = Clocks

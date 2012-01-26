class Clocks extends Spine.Controller
    constructor: ->
        super el: $('.datebox')

        Clock.bind 'refresh', (items) => @render items[0]
        Clock.bind 'change', (item) => @render item
        Clock.fetch()

    render: (item) => @html @view('clock')(item)

window.Clocks = Clocks

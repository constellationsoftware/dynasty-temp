class Accounts extends Spine.Controller
    el: '#account-summary'

    constructor: ->
        super

        Account.bind 'refresh', (accounts) => @render(accounts[0])

        # bind to global clock update event
        Spine.bind 'clock:update', @onClockUpdate

    render: (item) =>
        @html @view('account')(item)

    onClockUpdate: (clock) =>
        # refresh the scoring
        Account.fetch()


window.Accounts = Accounts

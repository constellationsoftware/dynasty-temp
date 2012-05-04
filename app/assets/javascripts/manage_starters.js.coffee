#= require templates/player_depth

$ ->
    $('#manage_starters button[href="#swap_player"]').on 'click', ->
        source = $(@)
        return false if source.hasClass('disabled')
        row = source.closest '.slot'
        player = row.children('.name').first().text()
        lineups = []
        for lineup_id in source.data().compatible
            # for reserve slots, restrict eligible to empty lineup slots
            lineup = $(".slot#{if row.hasClass('reserve') then '.empty' else ''}[data-id='#{lineup_id}']").first()
            if lineup.length > 0
                lineups.push
                    id:         lineup.data().id
                    name:       lineup.children('.name').first().text() or 'Empty'
                    position:   lineup.children('.position').first().text()
        $('#swap_player .title').first().text("Swap #{player} for which slot?")
        $('#swap_player .modal-body').first().html(JST.player_depth
            id: row.data().id,
            lineups: lineups,
            action: if row.hasClass('reserve') then 'unite' else 'swap'
        )

    # clear the content when we close the modal
    $('#swap_player').on 'hidden', ->
        $(@).find('.modal-body').first().empty()
        $(@).find('.modal-alert').first().empty()

    $('#swap_player').on 'click', '.btn', (e) ->
        source = $(@)
        data = source.data()
        source.button 'loading'
        source.siblings('.btn').attr 'disabled', true

        success = (request) ->
            from = $(".slot[data-id='#{data.from}']")
            fromEls = from.children('.player')
            fromContent = ($(el).html().toString() for el in fromEls)

            to = $(".slot[data-id='#{data.to}']")
            toEls =  to.children('.player')
            toContent = ($(el).html().toString() for el in toEls)

            fromEls.html((i, e) -> toContent[i])
            toEls.html((i, e) -> fromContent[i])

            if data.action is 'swap'
                # if we're swapping into an empty row, toggle the empty class
                if from.hasClass('empty')
                    from.removeClass('empty')
                    to.addClass('empty')
                else if to.hasClass('empty')
                    to.removeClass('empty')
                    from.addClass('empty')
            else if data.action is 'unite'
                to.removeClass('empty')
                from.remove()

            # additionally, we need to en/disable reserve buttons depending on the empty slot loadout
            $('#injury-reserve .slot button').each ->
                self = $(@)
                self.addClass('disabled')
                for lineup_id in self.data().compatible
                    empty_lineups = $(".slot.empty[data-id='#{lineup_id}']")
                    if empty_lineups.length > 0
                        self.removeClass('disabled')
                        return

            # reference to elements we want to trigger the highlight on
            highlightCells = $(from).add(to).children()
            $('#swap_player').one 'hidden', -> triggerHighlight(highlightCells)
            # close the modal
            $('#swap_player').modal 'hide'

        failure = (response, status, error) ->
            new Alert $('#swap_player .modal-alert').first(),
                type: 'error'
                message: "An error occurred: (#{response.status}) #{error}"
                close: ->
                    source.button 'reset'
                    source.siblings('.btn').attr 'disabled', false
        $.post("/lineups/#{data.action}/#{data.from}/with/#{data.to}").success(success).error(failure)
        e.preventDefault()

    triggerHighlight = (els) ->
        els.addClass('highlight')
        setTimeout((-> els.removeClass('highlight')), 0)

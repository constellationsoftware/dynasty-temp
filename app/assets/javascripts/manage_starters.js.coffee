#= require templates/player_depth

$ ->
    $('#starter button[href="#swap_player"]').on 'click', ->
        source = $(@)
        row = source.closest '.lineup'
        player = row.children('.name').first().text()
        lineups = []
        for lineup_id in source.data().compatible
            lineup = $(".lineup[data-id='#{lineup_id}']")
            if lineup?
                lineups.push
                    id:         lineup.data().id
                    name:       lineup.children('.name').first().text() or 'Empty'
                    position:   lineup.children('.position').first().text()
        $('#swap_player .title').first().text("Swap #{player} for which slot?")
        $('#swap_player .modal-body').first().html(JST.player_depth(id: row.data().id, lineups: lineups))

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
            fromEls = $(".lineup[data-id='#{data.from}']").children('.player')
            fromContent = ($(el).text().toString() for el in fromEls)
            toEls = $(".lineup[data-id='#{data.to}'] .player")
            toContent = ($(el).text().toString() for el in toEls)

            fromEls.text((i, e) -> toContent[i])
            toEls.text((i, e) -> fromContent[i])

            # close the modal
            $('#swap_player').modal 'hide'
        failure = (response, status, error) ->
            new Alert $('#swap_player .modal-alert').first(),
                type: 'error'
                message: "An error occurred: (#{response.status}) #{error}"
                close: ->
                    source.button 'reset'
                    source.siblings('.btn').attr 'disabled', false
        $.post("/lineups/swap/#{data.from}/with/#{data.to}").success(success).error(failure)
        e.preventDefault()

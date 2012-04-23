#= require templates/player_depth

$ ->
    revealLinks = $('[data-reveal-id]')
    for link in revealLinks
        e = $(link)
        e.data('opened', do (event) ->
            origin = $(link)
            originRow = e.closest('.lineup')
            data = e.closest('.lineup').data()
            ->
                originParent = origin.closest('.roster')
                target = originParent.siblings('.roster').first()
                compatibleLineups = []
                for row in $('.roster tr.lineup')
                    row = $(row)
                    rowData = row.data()
                    idx = rowData.compatible.indexOf data.id
                    if idx isnt -1
                        compatibleLineups.push(
                            id:         rowData.id
                            position:   row.children('.position').first().text()
                            name:       row.children('.name').first().text() or 'Empty'
                            depth:      if row.parents('#starter').length > 0 then 'Starter' else 'Bench'
                        )

                locals =
                    title:      "Who do you want to swap #{originRow.children('.name').first().text()} with?"
                    id:         data.id
                    players:    compatibleLineups
                $('#swap_player .main').first().html(JST.player_depth(locals))
        )
        e.data('closed', do (event) ->
            -> $('#swap_player .content').empty()
        )

    $('#swap_player').on 'click', 'a.button', (e) ->
        e.preventDefault()
        data = $(e.currentTarget).data()
        $.get "swap/#{data.from}/with/#{data.to}", (request) ->
            fromEls = $(".lineup[data-id='#{data.from}']").children('.player')
            fromContent = ($(el).text().toString() for el in fromEls)
            toEls = $(".lineup[data-id='#{data.to}'] .player")
            toContent = ($(el).text().toString() for el in toEls)

            fromEls.text((i, e) -> toContent[i])
            toEls.text((i, e) -> fromContent[i])

            # close the modal
            $('#swap_player').trigger 'reveal:close'

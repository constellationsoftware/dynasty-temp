$ ->
    revealLinks = $('[data-reveal-id]')
    for link in revealLinks
        e = $(link)
        e.data('opened', do (event) ->
            origin = $(link)
            data = e.closest('.lineup').data()
            ->
                originParent = origin.closest('.roster')
                target = originParent.siblings('.roster').first()
                console.log target
        )

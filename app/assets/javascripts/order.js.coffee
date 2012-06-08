$ ->
    # handle submitting modal forms
    $('.modal .cancel').on 'click', (e) ->
        $(@).closest('.modal').modal 'hide'
        false

    $('.modal .submit').on 'click', (e) ->
        e.preventDefault()
        form = $(@).closest('.modal').find('form')
        form.submit() if form?

    window.copyAddress = ->
        $('#x_ship_to_address').val($('#x_address').val())
        $('#x_ship_to_city').val($('#x_city').val())
        $('#x_ship_to_state').val($('#x_state').val())
        $('#x_ship_to_zip').val($('#x_zip').val())

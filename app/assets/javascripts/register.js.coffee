#= require_self
$ ->
    $('#registration-steps .btn').on 'click', -> return false

    $('#billing-address').hide()
    $('#billing-address-toggle input[type="checkbox"]').on 'change', (e) ->
        checked = $(@).prop('checked')
        if checked
            $('#billing-address').hide()
            $('#credit_card_address').val('')
            $('#credit_card_city').val('')
            $('#credit_card_state').val('')
            $('#credit_card_zip').val('')
        else
            $('#billing-address').show()

    $('#register').ajaxSuccess (e, transport) ->
        location = transport.getResponseHeader('location')
        window.location.reload() if location?
        #window.location = location if location?

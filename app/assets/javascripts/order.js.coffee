#= require jquery/formparams

$ ->
    # coerce datetime value into a time so the date select shows the correct selection
    year = $('#league_draft_attributes_start_datetime_1i').attr('value').toString()
    month = $('#league_draft_attributes_start_datetime_2i').attr('value').toString().lpad(2, '0')
    day = $('#league_draft_attributes_start_datetime_3i').attr('value').toString().lpad(2, '0')
    dateVal = year + '-' + month + '-' + day
    for option in $('#league_draft_attributes_start_datetime option')
        option = $(option)
        if option.attr('value') is dateVal
            option.attr('selected', 'selected')
        else
            option.attr('selected', null)

    $('#league_draft_attributes_start_datetime').change (e) ->
        dateArr = e.target.value.split('-')
        $('#league_draft_attributes_start_datetime_1i').attr('value', dateArr[0])
        $('#league_draft_attributes_start_datetime_2i').attr('value', dateArr[1])
        $('#league_draft_attributes_start_datetime_3i').attr('value', dateArr[2])


    # disables clicking on any disabled buttons
    $('.btn').on 'click', -> not $(@).hasClass('disabled')

    $('#payment-modal .btn.submit').on 'click', (e) ->
        modal = $(@).closest '.modal'

        # TODO: make this work with actual payment processing and set the user expiration date
        # callback processes payment response
        callback = ->
            # assume success
            $('.order-steps .payment.btn').removeClass('btn-default').addClass('btn-success').addClass('disabled')
            $('.order-steps .league.btn').removeClass('disabled')
            modal.modal 'hide'

        setTimeout callback, 300

    # disables the join/create league buttons when the "create private league" form is expanded
    $('#league-form').on 'show', -> $(@).closest('.modal-body').children('.btn').addClass('disabled')

    # enables the join/create league buttons when the "create private league" form is cancelled
    $('#league-form').on 'hidden', -> $(@).closest('.modal-body').children('.btn').removeClass('disabled')

    # close any accordions
    #$('#league-type-modal').on 'hidden', -> $(@).find('.collapse').collapse 'hide'

    $('#league-type-modal .btn.cancel').on 'click', (e) ->
        e.stopImmediatePropagation()
        $('#league-form').collapse 'hide'

    $('#league-type-modal .btn.submit').on 'click', (e) ->
        e.stopImmediatePropagation()
        submitButton = $(@)
        modal = $(@).closest '.modal'
        step = $('ol.order-steps .league.btn')
        source = $(@).closest 'form'
        data = source.formParams()

        success = ->
            modal.modal('hide')
            step.removeClass('btn-default').removeClass('btn-danger').addClass('btn-success').addClass('disabled')
            $('.order-steps .team.btn').removeClass('disabled')
        failure = (response, status, error) ->
            step.removeClass('btn-default').addClass('btn-danger')
            console.log "An error occurred: (#{response.status}) #{error}"
            submitButton.button 'reset'
            submitButton.siblings('.btn').attr 'disabled', false
#            new Alert $('#swap_player .modal-alert').first(),
#                type: 'error'
#                message: "An error occurred: (#{response.status}) #{error}"
#                close: ->
#                    source.button 'reset'
#                    source.siblings('.btn').attr 'disabled', false

        submitButton.button 'loading'
        submitButton.siblings('.btn').attr 'disabled', true
        $.post(source.attr('action'), data).success(success).error(failure)
        false

    # handle submitting modal forms
    $('.modal .submit').on 'click', (e) ->
        e.preventDefault()
        modal = $(@).closest '.modal'
        form = modal.find 'form'
        modal.find('.btn.cancel').addClass 'disabled'
        $(@).button 'loading'
        #form.submit() if form?
        false

    # handle all cancel/close actions
    $('.modal .close, .modal .cancel').on 'click', (e) ->
        modal = $(@).closest('.modal')
        modal.modal 'hide'
        false

    # reset stateful and disabled buttons when modal is closed
    $('.modal').on 'hidden', (e) ->
        modal = $(@)
        modal.find('.btn').button 'reset'
        modal.find('.btn').removeClass 'disabled'

    window.copyAddress = ->
        $('#x_ship_to_address').val($('#x_address').val())
        $('#x_ship_to_city').val($('#x_city').val())
        $('#x_ship_to_state').val($('#x_state').val())
        $('#x_ship_to_zip').val($('#x_zip').val())

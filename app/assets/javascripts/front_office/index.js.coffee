#= require ../templates/shared/confirmation_buttons

$ ->
    modal = $('#confirm_remove')
    modal.find('.modal-footer').html(JST['shared/confirmation_buttons'](type: 'YES_CANCEL'))
    confirmButton = modal.find('.btn.confirm').first()
    confirmButton.on 'click', ->
        data = $(@).data()
        window.location = data.url if data.url?
    $('#roster a.btn.remove').on 'click', (e) ->
        e.preventDefault()
        row = $(@).closest('.lineup')
        player_name = row.find('.name').first().text()
        modal.find('.title').first().text("Are you sure you want to waive #{player_name}?")
        confirmButton.data 'url', $(@).attr('href')
        modal.modal('show')

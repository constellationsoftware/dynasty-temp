#= require_self
$ ->
    $('#league_public').change (e) ->
        passwordField = $('#league_password_input')
        value = $(this).val()
        if value is 'true'
            passwordField.hide()
        else
            passwordField.show()

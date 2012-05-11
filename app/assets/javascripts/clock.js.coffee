$(document).ajaxSuccess (e, transport) ->
    response = $.parseJSON(transport.responseText)
    if response? # we expect the date as a response
        $('#date').text(response.date);

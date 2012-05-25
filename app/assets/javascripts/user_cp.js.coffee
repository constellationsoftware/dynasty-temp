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

    $('#schedule-draft.modal .submit').on 'click', (e) ->
        e.preventDefault()
        form = $(@).closest('.modal').find('form')
        form.submit() if form?

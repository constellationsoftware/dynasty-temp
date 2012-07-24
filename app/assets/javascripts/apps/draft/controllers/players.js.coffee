# custom filter-by-name callback
$.fn.dataTableExt.afnFiltering.push (settings, data, i) ->
    value = $('#filter-name').val()
    return true unless value?
    return true if data[3].toLowerCase().indexOf(value) isnt -1 or data[2].toLowerCase().indexOf(value) isnt -1 or ("#{data[2].toLowerCase()} #{data[3].toLowerCase()}").indexOf(value) isnt -1

# filter by watchlist status
$.fn.dataTableExt.afnFiltering.push (settings, data, i) ->
    rank = data[0]
    el = $('#filter-favorites')
    activated = el.hasClass('active')
    if activated
        return false if rank is false
    true

window.Players = class Players extends Spine.Controller
    playersLoaded: false

    constructor: ->
        super

        # listen for ext launch
        Spine.bind 'picked', @onPicked

        Player.bind 'refresh', @onRefresh
        Player.fetch dataType: 'json'

    onPicked: (player_id) =>
        console.log @, "someone picked player: #{player_id}"
        player = Player.find player_id
        console.log player
        player.updateAttribute 'available', false, ajax: false

        # manually mark player row inactive
        row = $("#player_#{player_id}")
        row.addClass 'inactive' if row?

        # sync table's cached record
        records = @table.dataTable()._("#player_#{player.id}")
        console.log records
        records[0].updateAttributes player.attributes(), ajax: false if records.length > 0

    onRefresh: (data) =>
        @trigger 'initialize' unless @playersLoaded
        @playersLoaded = true

    onRowDblClick: (e) ->
        el = $(@)
        return if el.hasClass 'inactive'
        matches = /player_([\d]+)/.exec(el.attr('id'))
        if matches?
            id = parseInt matches[1]
            console.log id
        e.preventDefault()
        false

    onRowClick: (e) ->
        el = $(@)
        el.siblings('.selected').removeClass 'selected'
        return if el.hasClass 'inactive'
        if el.hasClass 'selected' then el.removeClass 'selected' else el.addClass 'selected'

    render: (width, height) =>
        if @table?
            @table.closest('.dataTables_scrollBody').height(height - 26 - 37)
            @table.closest('.dataTables_scrollHead').width width
        else
            @table = @createTable height
            @table.on 'dblclick', 'tbody tr', @onRowDblClick
            @table.on 'click', 'tbody tr', @onRowClick
            @createFilters()

    createFilters: ->
        me = @

        # populate position filter options
        el = $('#filter-position')
        el.append "<option value=\"#{key}\">#{val}</option>" for key, val of window.positions

        # populate team filter options
        el = $('#filter-team')
        el.append "<option value=\"#{key}\">#{val}</option>" for key, val of window.teams

        callback = (e) ->
            el = $(@)
            if el.hasClass 'active'
                el.removeClass 'active'
                el.button 'inactive'
            else
                el.addClass 'active'
                el.button 'active'
            me.table.dataTable().fnDraw()
            el.button 'toggle'
        el = $('#filter-favorites')
        el.on 'click', callback

        $('#research .filters select').on 'change', ->
            el = $(@)

            # column to filter on is encoded in data-column attribute
            className = el.data 'column'
            columnIdx = me.columnIndexByName className
            me.table.fnFilter el.val(), columnIdx if columnIdx >= 0

        # listen for name filter typing changes
        $('#filter-name').on 'keyup', ->
            el = $(@)
            clearTimeout el.data('timeout')
            callback = ->
                me.table.dataTable().fnDraw()
            el.data('timeout', setTimeout(callback, 500))

    createTable: (height) =>
        @el = $('#research')
        @el.html JST["apps/draft/views/players"]

        players = Player.all()
        for player in players
            player.DT_RowId = "player_#{player.id}"
        
        table = @el.find('table').first().dataTable
            aaData: players
            aoColumns: [
                sName:          'favorite'
                sWidth:         '50px'
                sClass:         'dt-center'
                mDataProp:      'favorite'
                bUseRendered:   false
                fnRender:   (col) ->
                    data = col.aData
                    return '' if data.favorite is false
                    console.log data.favorite
                    '<img src="/draft/resources/images/icons/silk/star.png" />'
            ,
                sName:      'name'
                sWidth:     '120px'
                sClass:     'dt-left'
                mDataProp:  null
                aDataSort:  [ 3, 2 ]
                fnRender:   (col) ->
                    data = col.aData
                    "#{data.name.first_name[0]}. #{data.name.last_name}"
            ,
                sName:      'first_name'
                mDataProp:  'name.first_name'
                bVisible:   false

            ,
                sName:      'last_name'
                mDataProp:  'name.last_name'
                bVisible:   false
            ,
                sName:      'position'
                mDataProp:  'position.abbreviation'
                sClass:     'dt-center'

            ,
                sName:      'team'
                mDataProp:  'real_team.display_name.abbreviation'
                sClass:     'dt-center'
            ,
                sName:      'bye'
                mDataProp:  'contract.bye_week'
                sClass:     'dt-center'
            ,
                sName:      'contract_amount'
                mDataProp:  'contract.amount'
                sClass:     'dt-right'
                bUseRendered: false
                fnRender:   (col) ->
                    data = col.aData
                    "$#{$.formatNumber data.contract.amount, format: '#,###'}"
            ,
                sName:      'contract_total_amount'
                mDataProp:  'contract.summary'
                sClass:     'dt-right'
                bUseRendered: false
                fnRender:   (col) ->
                    data = col.aData
                    "$#{$.formatNumber data.contract.summary, format: '#,###'}"
            ,
                sName:      'contract_end_year'
                mDataProp:  'contract.end_year'
                sClass:     'dt-right'
            ,
                sName:      'points'
                mDataProp:  'points.points'
                sClass:     'dt-right'
            ,
                sName:      'passing_points'
                mDataProp:  'points.passing_points'
                sClass:     'dt-right'
            ,
                sName:      'rushing_points'
                mDataProp:  'points.rushing_points'
                sClass:     'dt-right'
            ,
                sName:      'defensive_points'
                mDataProp:  'points.defensive_points'
                sClass:     'dt-right'
            ,
                sName:      'fumble_points'
                mDataProp:  'points.fumbles_points'
                sClass:     'dt-right'
            ,
                sName:      'scoring_points'
                mDataProp:  'points.scoring_points'
                sClass:     'dt-right'
            ,
                sName:      'dollars_per_point'
                sClass:     'dt-right'
                mDataProp:  'dollars_per_point'
                bUseRendered: false
                fnRender:   (col) ->
                    data = col.aData
                    if data.dollars_per_point is 0 then '$0' else "$#{$.formatNumber data.dollars_per_point, format: '#,###'}"
            ,
                sName:      'games'
                mDataProp:  'points.games_played'
                sClass:     'dt-right'
            ,
                sName:      'id'
                bVisible:   false
                mDataProp:  'id'
                sClass:     'right'
            ]
            bAutoWidth: false
            bProcessing: true
            sDom: "<'row'r>tS<'row'<'span12'i>>"
            #bDeferRender: true
            sScrollY: "#{height - 26 - 37}px"
            asStripeClasses:[]
            oScroller:
                serverWait: 125
                #rowHeight: 26
            fnRowCallback: (row, player, i) ->
                $(row).addClass 'inactive' unless player.available
        table

    getRowId: (row) ->
        row = $(row)
        matches = /player_([\d]+)/.exec(row.attr('id'))
        if matches? and matches.length > 0 then parseInt matches[1] else null

    columnIndexByName: (name) ->
        for col, i in @table.fnSettings().aoColumns
            return i if col.sName is name
        -1

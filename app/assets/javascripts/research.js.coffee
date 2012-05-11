#= require jquery/datatables/scroller

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    dataTable = $('#research').dataTable
        aoColumns: [
            sName:      'id'
            bVisible:   false
            mDataProp:  'id'
        ,
            sName:      'name'
            sWidth:     '120px'
            mDataProp:  null
            aDataSort:  [ 'name.last_name', 'name.first_name' ]
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
        ,
            sName:      'team'
            mDataProp:  'real_team.name.abbreviation'
        ,
            sName:      'bye'
            mDataProp:  'contract.bye_week'
        ,
            sName:      'contract_amount'
            mDataProp:  'contract.amount'
            fnRender:   (col) ->
                data = col.aData
                "$#{$.formatNumber data.contract.amount, format: '#,###'}"
        ,
            sName:      'contract_total_amount'
            mDataProp:  'contract.summary'
            fnRender:   (col) ->
                data = col.aData
                "$#{$.formatNumber data.contract.summary, format: '#,###'}"
        ,
            sName:      'contract_end_year'
            mDataProp:  'contract.end_year'
        ,
            sName:      'points'
            mDataProp:  'points.points'
        ,
            sName:      'passing_points'
            mDataProp:  'points.passing_points'
        ,
            sName:      'rushing_points'
            mDataProp:  'points.rushing_points'
        ,
            sName:      'defensive_points'
            mDataProp:  'points.defensive_points'
        ,
            sName:      'fumble_points'
            mDataProp:  'points.fumbles_points'
        ,
            sName:      'scoring_points'
            mDataProp:  'points.scoring_points'
        ,
            sName:      'points_per_dollar'
            mDataProp:  null
            bSortable:  false
            fnRender:   (col) ->
                data = col.aData
                ppd = data.points.points / (data.contract.amount / 1000000)
                $.formatNumber ppd, format: '#.#'
        ,
            sName:      'games'
            mDataProp:  'points.games_played'
        ]
        fnServerData: (source, data, callback) -> $.get source, data, callback, 'json'
        bProcesing: true
        bServerSide: true
        sAjaxDataProp: 'players'
        sAjaxSource: 'research/players'
        sDom: "<'row'<'span12'f>rtiS>"
        bDeferRender: true
        sScrollY: '350px'
        asStripeClasses:[]
        oScroller:
            serverWait: 250
            #rowHeight: 26

    $('#research th select').on 'change', ->
        el = $(@)
        dataTable.fnFilter el.value

window.DraftApp = class DraftApp extends Spine.Controller
    ext: null

    constructor: ->
        super

        @playerGrid = new Players()
        @playerGrid.bind 'initialize', @onPlayersInitialized

    # When the player list is loaded, start the Ext app
    onPlayersInitialized: ->
        me = @
        Ext.Loader.setConfig
            enabled: true
            disableCaching: true
            paths:
                '<appName>': '.'
                'Ext': '/assets/extjs/src'
                'Ext.ux': '/assets/lib/extjs/ux'
                'Ext.override': '/assets/lib/extjs'

        Ext.application
            name: 'DynastyDraft'
            appFolder: '/draft/app'
            autoCreateViewport: true

            requires: [
                'DynastyDraft.window.Notification'
                'Ext.window.MessageBox'
                'Ext.override.data.Store'
                'Ext.override.data.proxy.Server'
                'Ext.override.data.reader.Json'
                'Ext.data.SequentialIdGenerator'
                'Ext.layout.container.Border'
                'Ext.tab.Panel'
                'Ext.form.field.ComboBox'
                'Ext.grid.column.Number'
                'Ext.grid.feature.Grouping'
                'Ext.form.Panel'
            ]

            models: 'Update'

            controllers: [
                'Ext.ux.util.AlwaysOnTop'
                'Roster'
                'AdminControls'
                'Picks'
                'DraftBoard'
                'ShoutBox'
                'RecommendedPicks'
            ]

            refs: [
                ref: 'tabBar',
                selector: 'viewport tabpanel'
            ]

            launch: ->
                me.ext = @
                window.extApp = @
                Ext.getBody().removeCls 'loading'
                @showDraftFinishedDialog() if DRAFT_STATE is 'finished'

                # render modal for "draft player" button
                draftModal = @renderDraftModal()
                draftModal.on 'click', '.confirm', Ext.Function.bind(@onConfirmPick, @)

                # render global "draft player" button
                draftButton = @renderDraftButton()
                draftButton.on 'click', Ext.Function.bind(@onDraftButtonClicked, @)
                # listen for navigation changes and show/hide the draft button accordingly
                cb = (tabBar, card) ->
                    if card.id is 'research' then @show() else @hide()
                @getTabBar().addListener 'tabchange', cb, draftButton

                # Attach countdown timer to countdown_wrap container
                countdown = new Countdown('#countdown-wrap')
                duration = 180
                @addListener @STATUS_PICKING,
                    ->
                        @start(duration)
                    countdown
                @addListener @STATUS_PICKED, countdown.clear, countdown
                @addListener @STATUS_PAUSED, countdown.resume, countdown
                @addListener @STATUS_RESUMED, countdown.pause, countdown
                @addListener @STATUS_RESET, countdown.clear, countdown
                @addListener @LIVE_PICK_MADE,
                    ->
                        @start(duration)
                    countdown
                @addListener @STATUS_STARTED,
                    ->
                        @start(duration)
                    countdown
                @addListener @PICK_UPDATE, countdown.clear, countdown
                countdown.bind 'timeout', Ext.Function.bind(@onTimeout, @)
                window.countdown = countdown

                Ext.tip.QuickTipManager.init();
                Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
                    showDelay: 50      # Show 50ms after entering target
                });

                JUG.bind 'draft:starting', Ext.Function.bind(@onStarting, @)
                JUG.bind 'draft:on-deck', Ext.Function.bind(@onDeck, @)
                JUG.bind 'draft:picking', Ext.Function.bind(@onTeamPicking, @) # other teams
                JUG.bind 'draft:picked', Ext.Function.bind(@onTeamPicked, @)
                JUG.bind 'draft:finished', Ext.Function.bind(@onDraftFinish, @)
                JUG.bind 'draft:reset', Ext.Function.bind(@onDraftReset, @)

                @getController('Picks').addListener('picksucceeded', @onPickSucceeded, @)

            onStarting: ->
                @fireEvent @STATUS_STARTING

            onDeck: (data) ->
                @fireEvent @STATUS_PICKING, data

            onTeamPicking: (payload) ->
                @fireEvent @LIVE_PICK_MADE

            onPick: (player_id) -> # when the client makes a pick
                player = Player.find player_id
                if player?
                    console.log 'player picked succeeded', player
                    @fireEvent @STATUS_PICKED, player_id

            onPickSucceeded: (pick) ->
                console.log "PICK SUCCEEDED!!!"
                @fireEvent @STATUS_PICK_SUCCESS, pick
                @fireEvent @STATUS_WAITING

            onTeamPicked: (payload) -> # when another team makes a pick
                # show notification bubble for pick
                msg = payload.team.name + " picked " + payload.player.name + "."
                App.Notification.notify msg

                # display pick in the shoutbox
                store = window.ShoutboxMessages
                model = store.model
                if model
                    record = model.create
                        user: payload.team.name
                        message: "picked " + payload.player.name
                        type: 'notice'
                    console.log record
                    store.add record

                @fireEvent @PICK_UPDATE, payload.pick
                Spine.trigger 'picked', payload.player.id

                if payload.team.id is window.CHANNEL
                    console.log "I MADE THAT PICK"
                    picksController = @getController('Picks')
                    #pick = picksController.getPicksStore().getById payload.pick.id
                    #console.log pick
                    picksController.fireEvent 'picksucceeded', payload.pick

            onDraftFinish: ->
                @showDraftFinishedDialog()
                @fireEvent @STATUS_FINISHED

            onDraftReset: (data) ->
                t = setTimeout 'window.location.reload()', 5000
                Ext.Msg.show
                    title: 'The draft has been reset!'
                    msg: """
                        An administrator has initiated a draft reset.
                        The page will refresh in 5 seconds.
                        Press the button below if you do not wish to wait.
                    """
                    icon: Ext.Msg.WARNING
                    buttons: Ext.MessageBox.OK
                    width: 400
                    fn: =>
                        clearTimeout t
                        window.location.reload()

            onPlayerPickFailed: ->
                console.log 'player pick failed'
                @fireEvent @STATUS_WAITING

            onTimeout: ->
                @fireEvent @TIMEOUT

            showDraftFinishedDialog: ->
                Ext.Msg.show
                    title: ''
                    msg: 'The draft is complete!'
                    icon: Ext.Msg.WARNING
                    buttons: Ext.MessageBox.OK
                    fn: => window.location = "http://#{window.location.host}/"

            # renders a modal that will present choice of drafting player
            renderDraftModal: ->
                # create container
                el = $ '<div id="draft-modal" class="modal fade hide"></div>'
                el.appendTo 'body'
                el

            onConfirmPick: (e) ->
                modal = $('#draft-modal')
                player_id = modal.data('player_id')
                @onPick player_id
                modal.modal 'hide'

            # renders a global button used to draft players
            renderDraftButton: ->
                # create container
                button = $ """
                    <div id="draft-button-wrap">
                        <button id="draft-button" class="btn btn-danger">
                            Draft Player
                        </button>
                    </div>
                    """
                button.appendTo 'body'
                button

            onDraftButtonClicked: (e) ->
                modal = $('#draft-modal')
                selectedRow = draftApp.playerGrid.table.find('tr.selected').first()
                player_id = draftApp.playerGrid.getRowId(selectedRow)
                if player_id? and modal?
                    modal.data 'player_id', player_id
                    player = Player.find player_id
                    modal.html(JST['apps/draft/views/draft_confirm'](player: player))
                    modal.modal 'show'

            STATUS_STARTING:        'starting'
            STATUS_STARTED:         'started'
            STATUS_PICKING:         'picking'
            STATUS_PICKED:          'picked'
            STATUS_PICK_SUCCESS:    'picksuccess'
            STATUS_WAITING:         'waiting'
            STATUS_PAUSED:          'paused'
            STATUS_RESUMED:         'resumed'
            STATUS_RESET:           'reset'
            STATUS_FINISHED:        'finished'
            LIVE_PICK_MADE:         'someone-made-a-pick'

            TIMEOUT:                'timeout'

            LEAGUE_CHANNEL_PREFIX:  'presence-draft-'
            PICK_UPDATE:            'pick_update'

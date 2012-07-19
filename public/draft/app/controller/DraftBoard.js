Ext.define('DynastyDraft.controller.DraftBoard', {
    extend: 'Ext.app.Controller',

    stores: [ 'DraftBoard' ],
    views: [ 'DraftBoard' ],

    refs: [{
        ref: 'draftboardGrid',
        selector: 'viewport draftboard',
    }],

    init: function() {
        this.control({
            'viewport roster': {},

        });
        this.getDraftBoardStore().load();
        this.application.addListener(this.application.PICK_UPDATE, this.onPickSucceeded, this);
    },

    onPickSuccess: function() {
        this.getDraftBoardStore().load();
    },

    onPickSucceeded: function(pick) {
        var store = this.getDraftBoardStore(),
            teamStore = this.application.getController('Picks').getTeamsStore(),
            team = teamStore.getById(pick.team_id),
            player = Player.find(pick.player_id);
        if (teamStore && team && player) {
            record = Ext.create('DynastyDraft.model.DraftedPlayers', {
                id: pick.player_id,
                full_name: player.fullName(),
                position: player.position.abbreviation,
                bye_week: player.contract.bye_week,
                contract: player.contract.amount,
                points: player.points.points,
                team: team.get('name')
            });
            store.add(record);
            this.getDraftboardGrid().getView().refresh(true);
        }
    }
});

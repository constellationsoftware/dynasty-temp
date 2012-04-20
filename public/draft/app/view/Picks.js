Ext.define('DynastyDraft.view.Picks', {
    extend: 'Ext.ux.DataView.Animated',

    alias: 'widget.picks',
    deferInitialRefresh: true,
    autoScroll: false,
    duration: 400,
    id: 'picks_scroller',
    tpl: Ext.create('Ext.XTemplate',
        '<tpl for=".">',
            '<div class="pick">',
                '<div class="team_image"></div>',
                '<div class="info">',
                    '<p title="{team_name}" style="overflow: hidden; white-space: nowrap;">{team_name}</p>',
                    '<p class="round">Round: {round} Pick: {pick}</p>',
                '</div>',
            '</div>',
        '</tpl>'
    ),
    itemSelector: '.pick',
    overItemCls : 'pick-hover'
});

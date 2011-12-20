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
                '<div class="team_pic">',
                    '<span style="overflow: hidden">{team_name}</span>',
                '</div>',
                '<div class="round">',
                    '<p>Round: {round} Pick: {pick}</p>',
                '</div>',
            '</div>',
        '</tpl>'
    ),
    itemSelector: '.pick',
    overItemCls : 'pick-hover'
});

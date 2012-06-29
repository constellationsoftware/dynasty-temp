Ext.define('DynastyDraft.view.Picks', {
    extend: 'Ext.ux.DataView.Animated',

    alias: 'widget.picks',
    deferInitialRefresh: true,
    autoScroll: false,
    duration: 400,
    id: 'picks_scroller',
    tpl: Ext.create('Ext.XTemplate',
        '<tpl for=".">',
            '<div class="pick" style="height: 120px; width: 120px">',
                '<div class="pick-order">Pick {pick_order}</div>',
                '<div class="team_image"></div>',
                '<div class="info">',
                    '<p title="{team_name}" style="overflow: hidden;">{team_name}</p>',
                '</div>',
            '</div>',
        '</tpl>'
    ),
    itemSelector: '.pick',
    overItemCls : 'pick-hover'
});

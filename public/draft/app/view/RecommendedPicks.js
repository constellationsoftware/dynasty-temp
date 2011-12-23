Ext.define('DynastyDraft.view.RecommendedPicks', {
    extend: 'Ext.view.View',

    alias: 'widget.recommendedpicks',
    //deferInitialRefresh: true,
    //duration: 400,
    tpl: Ext.create('Ext.XTemplate',
        '<tpl for=".">',
            '<div class="recommended_pick_wrap">',
                '<div class="recommended_pick">',
                    '<div class="stats_wrap">',
                        '<div class="stats_content">',
                            '<div class="title">',
                                '<span class="name">{full_name}</span> ({position})',
                                '<div class="edit"></div>',
                            '</div>',
                            '<div class="salary">{contract_amount:usMoney}</div>',
                            '<dl class="stats">',
                                '<dt class="label">Pts: </dt>',
                                '<dd class="points">{points} <span class="delta">&nbsp;</span></dd>',
                                '<dt class="label">Rat: </dt>',
                                '<dd class="rating">{rating} <span class="delta">&nbsp;</span></dd>',
                                '<dt class="label">Cons: </dt>',
                                '<dd class="consistency">{consistency} <span class="delta">&nbsp;</span></dd>',
                            '</dl>',
                        '</div>',
                    '</div>',
                    '<div class="bio">',
                        '<div class="photo"></div>',
                    '</div>',
                    '<div class="footer"></div>',
                '</div>',
            '</div>',
        '</tpl>'
    ),
    itemSelector: '.recommended_pick_wrap',
    singleSelect: true,
    selectedItemCls: 'selected'
});

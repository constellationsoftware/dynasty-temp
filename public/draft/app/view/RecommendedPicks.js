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
                            '<div class="stats">',
                                '<ul class="stat_columns">',
                                    '<li class="defensive_points">',
                                        '<span class="label">Defensive:</span>',
                                        '<span class="points">{defensive_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="fumbles_points">',
                                        '<span class="label">Fumbles:</span>',
                                        '<span class="points">{fumbles_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="passing_points">',
                                        '<span class="label">Passing:</span>',
                                        '<span class="points">{passing_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="rushing_points">',
                                        '<span class="label">Rushing:</span>',
                                        '<span class="points">{rushing_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="sacks_against_points">',
                                        '<span class="label">Sacks Against:</span>',
                                        '<span class="points">{sacks_against_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="scoring_points">',
                                        '<span class="label">Scoring:</span>',
                                        '<span class="points">{scoring_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="special_teams_points">',
                                        '<span class="label">Special Teams:</span>',
                                        '<span class="points">{special_teams_points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    '<li class="games_played">',
                                        '<span class="label">Games Last Season:</span>',
                                        '<span class="points">{games_played} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                    //'<dt class="label">Cons: </dt>',
                                    //'<dd class="consistency">{consistency} <span class="delta">&nbsp;</span></dd>',
                                '</ul>',
                                '<ul class="total">',
                                    '<li class="points">',
                                        '<span class="label">Total: </span>',
                                        '<span class="points">{points} <span class="delta">&nbsp;</span></span>',
                                    '</li>',
                                '</ul>',
                            '</div>',
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

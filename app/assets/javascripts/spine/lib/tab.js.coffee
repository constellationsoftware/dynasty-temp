###
 This file provides a controller with reasonable defaults for a controller
 managing a twitter bootstrap tab view
###

class Spine.Tab extends Spine.Controller
    constructor: (config) ->
        super
        return
        $("a[data-toggle='tab']").on 'shown', (e) => @onActivate e.target, e.relatedTarget
        # we must remove the active class so bootstrap will fire a show event
        # as if we were clicking it for the first time
        tabs = @el.find('.tab')
        activeTab = tabs.filter('.active').first()
        if activeTab.length > 0
            tabs.removeClass 'active'
        else
            activeTab = tabs.first()
        # activate the active tab or the first one
        activeTab.children('a').tab('show')
    onActivate: (tab, previousTab) -> throw 'You must override the "onActivate" method.'

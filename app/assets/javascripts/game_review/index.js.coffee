#= require json2
#= require spine/lib/spine
#= require spine/lib/manager
#= require spine/lib/route
#= require spine/lib/list
#= require spine/lib/ajax
#= require spine/lib/tab
#= require lib/juggernaut/juggernaut_spine
#= require spine/lib/view
#= require i18n
#= require i18n/translations

#= require_tree ./views
#= require_tree ./models
#= require_tree ./controllers
#= require_self
$ -> window.app = new GameReview()

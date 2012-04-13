#= require json2
#= require spine/lib/spine
#= require spine/lib/manager
#= require spine/lib/route
#= require spine/lib/list
#= require spine/lib/ajax
#= require lib/juggernaut/juggernaut_spine
#= require inflections
#= require spine/lib/tab

#= require_tree ./lib
#= require_tree ./views
#= require_tree ./models
#= require_tree ./controllers
#= require_self
$ -> window.APP = new TeamManager()

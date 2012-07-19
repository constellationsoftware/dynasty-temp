#= require jquery
#= require jquery_ujs
#= require ext
#= require lib/juggernaut/juggernaut_dispatcher
#= require inflections

#= require spine/lib/spine
#= require spine/lib/ajax

#= require dataTables/jquery.dataTables
#= require dataTables/jquery.dataTables.bootstrap
#= require dataTables.fnGetColumnData
#= require jquery/datatables/scroller

#= require hamlcoffee
#= require lib/util
#= require twitter/bootstrap

#= require ./countdown
#= require_tree ./models
#= require_tree ./views
#= require ./controllers/players
#= require ./controllers/app

#= require_self

$ ->
	window.draftApp = new DraftApp()
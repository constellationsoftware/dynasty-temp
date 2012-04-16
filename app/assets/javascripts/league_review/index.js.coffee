#= require json2
#= require spine/lib/spine
#= require spine/lib/manager
#= require spine/lib/route
#= require spine/lib/list
#= require spine/lib/ajax
#= require lib/juggernaut/juggernaut_spine
#= require spine/lib/view
#= require i18n
#= require i18n/translations

#= require_tree ./views
#= require_tree ./models
#= require_tree ./controllers
#= require_self
$ -> window.app = new GameReview()
#    elements:
#        '#week_1Tab': 'week1Content'
#        '#week_2Tab': 'week2Content'
#        '#week_3Tab': 'week3Content'
#        '#week_4Tab': 'week4Content'
#        '#week_5Tab': 'week5Content'
#        '#week_6Tab': 'week6Content'
#        '#week_7Tab': 'week7Content'
#        '#week_8Tab': 'week8Content'
#        '#week_9Tab': 'week9Content'
#        '#week_10Tab': 'week10Content'
#        '#week_11Tab': 'week11Content'

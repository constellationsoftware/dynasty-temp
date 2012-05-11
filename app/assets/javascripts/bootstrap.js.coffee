jQuery ->

  $("a[rel='tooltip']").tooltip()
  $("a[rel='popover']").popover()
  $('.logo').popover()
  $(".tooltip").tooltip()
  $('.dropdown-toggle').dropdown()
  $('.tab-pane').tab()

  $(".career-data").dataTable
    sPaginationType: "bootstrap"
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: 500
    iDisplayLength: 25


  $(".season-data").dataTable
    sPaginationType: "bootstrap"
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: 500
    iDisplayLength: 25


  $(".team-financials-data").dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap"
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: 500
    iDisplayLength: 25

  $(".league-review-calendar").dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap"
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: 500
    iDisplayLength: 25

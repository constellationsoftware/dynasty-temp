jQuery ->

  $("a[rel='tooltip']").tooltip()
  $("a[rel='popover']").popover()
  $('.logo').popover()
  $(".tooltip").tooltip()
  $('.dropdown-toggle').dropdown()
  #$(".collapse").collapse() # opens all current accordions or something?
  $('.tab-pane').tab()
  $(".all-players-data").dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap",
    sScrollY: 500

  $(".career-data").dataTable
    sPaginationType: "bootstrap",
    sScrollY: 250

  $(".season-data").dataTable
    sPaginationType: "bootstrap",
    sScrollY: 250

  $(".team-financials-data").dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    bScrollInfinite: true,
    bScrollCollapse: true,
    sScrollY: 500

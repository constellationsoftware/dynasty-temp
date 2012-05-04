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
        sPaginationType: "bootstrap"
        iDisplayLength: 25
        sScrollY: 500

  #$(".collapse").collapse() # opens all current accordions or something?
  $('.tab-pane').tab()



  oTable = $(".all-players-data").dataTable
    sDom: "<'row'<'span6'l><'span12'f>r>t<'row'<'span6'i><'span6'p>>",
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: 500
    iDisplayLength: 25
    sSearch: "Search all columns:"


  $("thead th").each (i) ->
    $("select", this).change ->
      oTable.fnFilter $(this).val(), i




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
=======
    $(".career-data").dataTable
        sPaginationType: "bootstrap"
        sScrollY: 250

    $(".season-data").dataTable
        sPaginationType: "bootstrap"
        sScrollY: 250

    $(".team-financials-data").dataTable
        sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
        sPaginationType: "bootstrap"
        iDisplayLength: 25
        sScrollY: 500
>>>>>>> f969f764fb858690c9bfc0d41ba855c7d18b7aa5

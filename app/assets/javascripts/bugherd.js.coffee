((d, t) ->
  bh = d.createElement(t)
  s = d.getElementsByTagName(t)[0]
  bh.type = "text/javascript"
  bh.src = "//www.bugherd.com/sidebarv2.js?apikey=73e8ce35-f33a-43cb-a413-c39fd7b1db2b"
  s.parentNode.insertBefore bh, s
) document, "script"
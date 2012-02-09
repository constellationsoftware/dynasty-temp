class Messages extends Spine.Controller
  constructor: ->
    super el: $('.messages')

    Message.bind 'refresh', (items) => @render items[0]
    Message.bind 'change', (item) => @render item
    Message.fetch()

  render: (item) => @html @view('message')(item)

window.Messages = Messages

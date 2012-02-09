class Message extends Spine.Model
    @configure 'Message', 'content'
    @extend Spine.Model.Ajax

    @url: '/messages/1'



window.Message = Message

class Player extends Spine.Model
    @configure 'Player', 'first_name', 'last_name', 'position', 'contract', 'bye_week', 'depth'
    @extend Spine.Model.Ajax

    @url: '/team/players'
    name: -> [@first_name.charAt(0), @last_name].join('. ')

window.Player = Player

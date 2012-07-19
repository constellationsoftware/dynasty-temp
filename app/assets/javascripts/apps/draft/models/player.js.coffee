window.Player = class Player extends Spine.Model
    @configure 'Player', 'id', 'available', 'name', 'position', 'contract', 'points', 'favorite'
    @extend Spine.Model.Ajax

    @url: '/research/players'

    fullName: -> "#{@name.first_name} #{@name.last_name}"

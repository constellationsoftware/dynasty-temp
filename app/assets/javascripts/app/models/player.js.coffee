class Starter extends Spine.Model
    @configure 'Starter', 'flex', 'position', 'player'
    @extend Spine.Model.Ajax
    @url: '/team/lineup'

    name: (player) -> [player.first_name.charAt(0), player.last_name].join('. ')


window.Starter = Starter

class BenchWarmer extends Spine.Model
    @configure 'BenchWarmer', 'first_name', 'last_name', 'contract', 'player_id', 'position'
    @extend Spine.Model.Ajax
    @url: '/team/roster/bench'

    name: => [@first_name.charAt(0), @last_name].join('. ')

window.BenchWarmer = BenchWarmer

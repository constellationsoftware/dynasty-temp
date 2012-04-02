class Starter extends Spine.Model
    @configure 'Starter', 'flex', 'position', 'player'
    @extend Spine.Model.Ajax
    @url: '/team/lineup'

    name: (player) -> [player.first_name.charAt(0), player.last_name].join('. ')
    guaranteed_remaining: (player) -> if player.guaranteed is '$0.00' then 'n/a' else player.guaranteed

window.Starter = Starter

class BenchWarmer extends Spine.Model
    @configure 'BenchWarmer', 'first_name', 'last_name', 'contract', 'player_id', 'position', 'guaranteed'
    @extend Spine.Model.Ajax
    @url: '/team/roster/bench'

    name: => [@first_name.charAt(0), @last_name].join('. ')

window.BenchWarmer = BenchWarmer

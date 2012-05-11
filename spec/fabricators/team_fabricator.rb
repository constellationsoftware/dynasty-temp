# == Schema Information
#
# Table name: dynasty_teams
#
#  id             :integer(4)      not null, primary key
#  league_id      :integer(4)
#  name           :string(50)      not null
#  user_id        :integer(4)      not null
#  is_online      :boolean(1)      default(FALSE), not null
#  uuid           :binary(255)
#  last_socket_id :string(255)
#  balance_cents  :integer(8)      default(0), not null
#  autopick       :boolean(1)      default(FALSE)
#  waiver_order   :integer(4)
#  draft_order    :integer(4)
#

Fabricator :team do
    name { Forgery::Name.team_name(true) }
    league
    user! { |team| Fabricate :user, :team => team }
end

Fabricator :team_with_players, :from => :team do
    player_teams!(:count => (Lineup.count)) { |team, i|
        lineup = Lineup.with_positions.where{ id == my{ i } }.first
        player = Player.available(team.league.id).recommended(team.id, lineup).first
        Fabricate(:player_team, :team => team, :lineup => lineup, :player => player)
    }
end

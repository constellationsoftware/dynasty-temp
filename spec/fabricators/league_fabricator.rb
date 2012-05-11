# == Schema Information
#
# Table name: dynasty_leagues
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(50)      not null
#  created_at            :datetime
#  updated_at            :datetime
#  manager_id            :integer(4)
#  slug                  :string(255)
#  default_balance_cents :integer(8)      default(0), not null
#  public                :boolean(1)      default(TRUE)
#  password              :string(32)
#  teams_count           :integer(4)
#  clock_id              :integer(4)
#  balance_cents         :integer(8)      default(0)
#

Fabricator :league do
    name { sequence(:name) { |i| "League #{i + 1}" } }
    teams []
end

Fabricator :league_full, :from => :league do
    teams!(:count => (Settings.league.capacity)) { |league| Fabricate(:team_with_players, :league => league) }
end

Fabricator :league_no_draft, :from => :league do
    teams!(:count => (Settings.league.capacity)) { |league| Fabricate(:team, :league => league) }
end

require 'factory_girl'

FactoryGirl.define do
  factory :user do |f|
    f.email 'testuser@example.com'
    f.password 'password'
    f.password_confirmation 'password'
  end

  factory :user_team do |f|
    f.name 'test team'
    f.league_id '1'
    f.user_id '1' # this is a place holder
  end
  
  factory :player_team_record do |f|
    f.player_id '1229'
    f.user_team_id '1' # this is a place holder
    f.position_id '1'
    f.league_id '1'
    f.current '1'
    f.details 'Drafted in round 1'
    f.added_at '2012-01-08 00:50:07'
    f.depth '1'
  end
end
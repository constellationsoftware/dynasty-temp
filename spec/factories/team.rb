FactoryGirl.define do
    factory :team, :class => Team do
        name        'Kibbles n Vicks'
        balance     Settings.team.initial_balance
        association :league, :factory => :bros
        user
    end
end

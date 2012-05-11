FactoryGirl.define do
    factory :league do
        sequence(:name) {|n| "League #{n}" }
        size    16

        factory :bros do
            name    'Bros'
        end
    end
end

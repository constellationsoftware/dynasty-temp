FactoryGirl.define do
    factory :player do
        person_key ''
        publisher_id 0
        factory :drew do
            association :position, :factory => :quarterback
        end
        association :contract, :strategy => :build
    end

    factory :player_name, :class => DisplayName do
        first_name  'Drew'
        last_name   'Brees'
        full_name   { "#{first_name} #{last_name}" }
        association :player, :factory => :drew
    end
end

FactoryGirl.define do
    factory :position do
        trait :offense do
            designation 'o'
        end
        trait :defense do
            designation 'd'
        end
        trait :offensive_flex do
            association :flex_position, :factory => :offensive_flex
        end

        factory :quarterback do
            name            'Quarterback'
            abbreviation    'qb'
            sort_order      1
            offense
        end

        factory :running_back do
            name            'Running Back'
            abbreviation    'rb'
            sort_order      2
            offense
            offensive_flex
        end

        factory :wide_receiver do
            name            'Wide Receiver'
            abbreviation    'wr'
            sort_order      3
            offense
            offensive_flex
        end

        factory :tight_end do
            name            'Tight End'
            abbreviation    'te'
            sort_order      4
            offense
            offensive_flex
        end

        factory :kicker do
            name            'Kicker'
            abbreviation    'k'
            sort_order      5
            offense
        end

        factory :defensive_lineman do
            name            'Defensive Lineman'
            abbreviation    'dl'
            sort_order      6
            defense
            defensive_flex
        end

        factory :linebacker do
            name            'Linebacker'
            abbreviation    'lb'
            sort_order      7
            defense
            defensive_flex
        end

        factory :defensive_back do
            name            'Defensive Back'
            abbreviation    'db'
            sort_order      8
            defense
            defensive_flex
        end

        factory :offensive_flex do
            name            'Offensive Flex'
            abbreviation    'flex'
            sort_order      9
            offense
        end

        factory :defensive_flex do
            name            'Defensive Flex'
            abbreviation    'dflex'
            sort_order      10
            offense
        end
    end
end

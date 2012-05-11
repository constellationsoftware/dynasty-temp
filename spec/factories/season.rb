FactoryGirl.define do
    factory :season do
        affiliation     'nfl'
        weeks           16

        factory :current_season do
            year            2011
            current         1
            start_date      '2011-09-08'.to_date
            end_date        '2012-01-01'.to_date
        end
    end
end

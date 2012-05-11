FactoryGirl.define do
    factory :contract do
        amount      1000000
        length      3
        guaranteed  0
        end_year { Date.today.year }

        # contract weekly payout is normalized to number of weeks for the current season
        factory :normalized_contract do
            amount      { Season.current.weeks }

            # guaranteed amount will be paid halfway through the season
            factory :mid_season_guaranteed_contract do
                length      1
                guaranteed  { amount / 2 }
            end
            # guaranteed amount will be paid at the end of the season
            factory :end_of_season_guaranteed_contract do
                length      1
                guaranteed  { amount }
            end

            factory :guaranteed_contract_paid do
                end_year    { Date.today.year + 1 }
                guaranteed  { (length - 1) * amount }
            end
        end
    end
end

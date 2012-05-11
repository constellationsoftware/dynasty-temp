FactoryGirl.define do
    factory :account do
        amount                  0
        transaction_datetime    { DateTime.now }

        factory :player_salary_transaction, :class => PlayerAccount do
            ignore do
                #association :payable, :factory => :player_team
                association :receivable, :factory => :player_team
            end
        end
    end
end

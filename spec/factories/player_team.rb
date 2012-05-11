FactoryGirl.define do
    factory :player_team, :class => PlayerTeam do
        current     1
        team
        league      {|pt| pt.team.league }
        association :player, :factory => :drew

        factory :player_team_with_weekly_receipts do
            ignore do
                transaction_count       0
                transaction_start_date  DateTime.now
            end

            after_build do |player_team, evaluator|
                start_date = evaluator.transaction_start_date
                player_team.receipts = (1..evaluator.transaction_count).to_a.collect do |i|
                    FactoryGirl.create :player_salary_transaction,
                        :amount => 1,
                        :receivable => player_team,
                        :transaction_datetime => start_date.advance(:weeks => i)
                end
            end
        end
    end
end

FactoryGirl.define do
    factory :user do
        first_name 'Joe'
        last_name 'Blow'
        email { "#{first_name.downcase}.#{last_name.downcase}@example.com" }
        password 'password'
        password_confirmation 'password'
        role 'user'

        factory :nick do
            first_name 'Nick'
            last_name 'Watkins'
        end

        factory :ben do
            first_name 'Ben'
            last_name 'Murphy'
        end

        factory :paul do
            first_name 'Paul'
            last_name 'Gabrail'
        end

        factory :andrew do
            first_name 'Andrew'
            last_name 'Strigle'
        end
    end
end

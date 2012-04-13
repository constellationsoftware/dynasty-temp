Fabricator :user do
    first_name { Forgery::Name.first_name }
    last_name { Forgery::Name.last_name }
    email do |user|
        sequence :email do |i|
            "#{user.first_name.parameterize('.')}.#{user.last_name.parameterize('.')}#{i}@example.com"
        end
    end
    password 'password'
    password_confirmation { |user| user.password }
    phone { Forgery::Address.phone }
    team
    address! { |user| Fabricate :user_address, :user => user }
end

Fabricator :user_address do
    street { Forgery::Address.street_address }
    city { Forgery::Address.city }
    state { Forgery::Address.state_abbrev }
    zip { Forgery::Address.zip }
    country 'USA'
    user
end

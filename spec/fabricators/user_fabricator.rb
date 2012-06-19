Fabricator :user do
    first_name { Forgery::Name.first_name }
    last_name { Forgery::Name.last_name }
    username { |attrs| (attrs[:first_name][0]).downcase + attrs[:last_name].parameterize }
    email { |attrs| "#{attrs[:first_name].parameterize('.')}.#{attrs[:last_name].parameterize('.')}@example.com" }
    password 'password'
    password_confirmation { |attrs| attrs[:password] }
    phone { Forgery::Address.phone }
    address{ Fabricate(:user_address) }
    tier 'all-pro'
end

Fabricator :user_address do
    street { Forgery::Address.street_address }
    city { Forgery::Address.city }
    state { Forgery::Address.state_abbrev }
    zip { Forgery::Address.zip }
    country 'USA'
end

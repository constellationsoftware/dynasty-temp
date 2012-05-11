# == Schema Information
#
# Table name: dynasty_users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string(255)
#  last_seen              :datetime
#  first_name             :string(50)      not null
#  role                   :string(255)
#  roles_mask             :integer(4)
#  phone                  :string(32)
#  last_name              :string(50)      not null
#

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

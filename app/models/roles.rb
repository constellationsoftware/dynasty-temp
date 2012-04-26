# == Schema Information
#
# Table name: roles
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  resource_id   :integer(4)
#  resource_type :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Roles < ActiveRecord::Base
    has_and_belongs_to_many :users, :join_table => users_roles
end

# == Schema Information
#
# Table name: publishers
#
#  id             :integer(4)      not null, primary key
#  publisher_key  :string(100)     not null
#  publisher_name :string(100)
#

class Publisher < ActiveRecord::Base
end

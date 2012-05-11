# == Schema Information
#
# Table name: document_packages
#
#  id           :integer(4)      not null, primary key
#  package_key  :string(100)
#  package_name :string(100)
#  date_time    :date
#

class DocumentPackage < ActiveRecord::Base
end

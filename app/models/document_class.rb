# == Schema Information
#
# Table name: document_classes
#
#  id   :integer(4)      not null, primary key
#  name :string(100)
#

class DocumentClass < ActiveRecord::Base
    has_many :document_fixtures
end

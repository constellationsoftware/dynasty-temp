# == Schema Information
#
# Table name: document_fixtures
#
#  id                :integer(4)      not null, primary key
#  fixture_key       :string(100)
#  publisher_id      :integer(4)      not null
#  name              :string(100)
#  document_class_id :integer(4)      not null
#

class DocumentFixture < ActiveRecord::Base
    belongs_to :document_class
    has_many :documents
end

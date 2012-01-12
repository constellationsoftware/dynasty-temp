class DocumentFixture < ActiveRecord::Base
    belongs_to :document_class
    has_many :documents
end

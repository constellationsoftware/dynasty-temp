class DocumentFixtureEvent < ActiveRecord::Base
    belongs_to :document_fixture
    belongs_to :event
end

class Document < ActiveRecord::Base
    belongs_to :document_fixture
    has_one :document_content
    has_and_belongs_to_many :events, :join_table => "events_documents"
    has_and_belongs_to_many :persons, :join_table => "persons_documents"
    has_and_belongs_to_many :teams, :join_table => "teams_documents"
    has_and_belongs_to_many :affiliations, :join_table => "affiliations_documents"
end


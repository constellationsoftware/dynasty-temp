# == Schema Information
#
# Table name: documents
#
#  id                   :integer(4)      not null, primary key
#  doc_id               :string(75)      not null
#  publisher_id         :integer(4)      not null
#  date_time            :datetime
#  title                :string(255)
#  language             :string(100)
#  priority             :string(100)
#  revision_id          :string(255)
#  stats_coverage       :string(100)
#  document_fixture_id  :integer(4)      not null
#  source_id            :integer(4)
#  db_loading_date_time :datetime
#

class Document < ActiveRecord::Base
    belongs_to :document_fixture
    has_one :document_content
    has_and_belongs_to_many :events, :join_table => "events_documents"
    has_and_belongs_to_many :persons, :join_table => "persons_documents"
    has_and_belongs_to_many :teams, :join_table => "teams_documents", :class_name => 'SportsDb::Team'
    has_and_belongs_to_many :affiliations, :join_table => "affiliations_documents"
end


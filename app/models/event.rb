class Event < ActiveRecord::Base
  # TODO: Associated participating players to lock for trading and score calculations
  has_polymorphic_as_table
  belongs_to :site
  has_and_belongs_to_many :documents, :join_table => "events_documents"
  has_and_belongs_to_many :medias
  has_many :stats, :as => :stat_coverage

end

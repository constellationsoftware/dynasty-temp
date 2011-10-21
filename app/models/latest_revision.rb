class LatestRevision < ActiveRecord::Base
  # TODO: Check that this is used properly to calculate the right scoring @ any point in time.
  belongs_to :document, :foreign_key => :latest_document_id
end

# == Schema Information
#
# Table name: latest_revisions
#
#  id                 :integer(4)      not null, primary key
#  revision_id        :string(255)     not null
#  latest_document_id :integer(4)      not null
#

class LatestRevision < ActiveRecord::Base
    # TODO: Check that this is used properly to calculate the right scoring @ any point in time.
    belongs_to :document, :foreign_key => :latest_document_id
end

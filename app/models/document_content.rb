# == Schema Information
#
# Table name: document_contents
#
#  id            :integer(4)      not null, primary key
#  document_id   :integer(4)      not null
#  sportsml      :string(200)
#  sportsml_blob :text
#  abstract      :text
#  abstract_blob :text
#

class DocumentContent < ActiveRecord::Base
    belongs_to :document
end

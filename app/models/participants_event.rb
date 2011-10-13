class ParticipantsEvent < ActiveRecord::Base
  is_polymorphic_as_table
  belongs_to :event
  belongs_to :participants, :polymorphic => true
  has_many :periods
end

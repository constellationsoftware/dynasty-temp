class ParticipantsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :participants, :polymorphic => true
  has_many :periods
end

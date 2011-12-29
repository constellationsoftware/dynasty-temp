class ParticipantsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :participants, :polymorphic => true
  has_many :periods


  def self.home
    self.where{alignment == 'home'}

  end

  def self.away
    self.where{alignment == 'away'}
  end

  def self.winner
    self.where{event_outcome == 'win'}
  end

  def self.loser
    self.where{event_outcome == 'loss'}
  end

  def self.winner_score
    self.teams.where{event_outcome == 'win'}
  end

  def self.loser_score
    self.teams.where{event_outcome == 'loss'}
  end

  scope :home, home
  scope :away, away
  scope :winner, winner
  scope :loser, loser
end

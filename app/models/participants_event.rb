# == Schema Information
#
# Table name: participants_events
#
#  id               :integer(4)      not null, primary key
#  participant_type :string(100)     not null
#  participant_id   :integer(4)      not null
#  event_id         :integer(4)      not null
#  alignment        :string(100)
#  score            :string(100)
#  event_outcome    :string(100)
#  rank             :integer(4)
#  result_effect    :string(100)
#  score_attempts   :integer(4)
#  sort_order       :string(100)
#  score_type       :string(100)
#

class ParticipantsEvent < ActiveRecord::Base
    belongs_to :event
    belongs_to :participants, :polymorphic => true
    has_many :periods



    def self.home
        self.where { alignment == 'home' }

    end

    def self.away
        self.where { alignment == 'away' }
    end

    def self.winner
        self.where { event_outcome == 'win' }
    end

    def self.loser
        self.where { event_outcome == 'loss' }
    end

    def self.winner_score
        self.teams.where { event_outcome == 'win' }
    end

    def self.loser_score
        self.teams.where { event_outcome == 'loss' }
    end

    scope :home, home
    scope :away, away
    scope :winner, winner
    scope :loser, loser
end

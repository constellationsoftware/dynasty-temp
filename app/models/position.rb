class Position < ActiveRecord::Base
  has_many :person_phases, :foreign_key => "regular_position_id"
  belongs_to :affiliation

  def self.quarterback
    Position.where(:name => 'Quarterback').map(&:id)
  end

  def self.runningback
    Position.where(:name => 'Running Back').map(&:id)
  end

  def self.widereceiver
    Position.where(:name => 'Wide Receiver').map(&:id)
  end

  def self.tightend
    Position.where(:name => 'Tight End').map(&:id)
  end

end

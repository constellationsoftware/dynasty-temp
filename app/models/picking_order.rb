class PickingOrder < ActiveRecord::Base
  belongs_to :round
  belongs_to :user_team

  requires :association, :user_team, :round

  locks :association, :user_team, :round
  locks :attribute, :position

  validates_presence_of :position
  validates_uniqueness_of :position, :scope => [:round_id]
end

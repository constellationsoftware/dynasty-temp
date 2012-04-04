class PickingOrder < ActiveRecord::Base
    belongs_to :round
    belongs_to :team

    # requires :association, :team, :round


    # locks :association, :team, :round
    # locks :attribute, :position

    validates_presence_of :position
    validates_uniqueness_of :position, :scope => [:round_id]
end

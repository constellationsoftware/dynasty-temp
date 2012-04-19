# == Schema Information
#
# Table name: dynasty_draft_picks
#
#  id         :integer(4)      not null, primary key
#  player_id  :integer(4)
#  draft_id   :integer(4)      default(0), not null
#  team_id    :integer(4)      not null
#  pick_order :integer(4)      default(0), not null
#  picked_at  :datetime
#  round      :integer(4)      not null
#

class Pick < ActiveRecord::Base
    self.table_name = 'dynasty_draft_picks'

    belongs_to :team
    has_one :user, :through => :team
    belongs_to :player
    belongs_to :draft, :inverse_of => :picks
end

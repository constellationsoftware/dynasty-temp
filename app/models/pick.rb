class Pick < ActiveRecord::Base
    self.table_name = 'dynasty_draft_picks'

    belongs_to :team
    has_one :user, :through => :team
    belongs_to :player
    belongs_to :draft, :inverse_of => :picks
end

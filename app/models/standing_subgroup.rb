# == Schema Information
#
# Table name: standing_subgroups
#
#  id                   :integer(4)      not null, primary key
#  standing_id          :integer(4)      not null
#  affiliation_id       :integer(4)      not null
#  alignment_scope      :string(100)
#  competition_scope    :string(100)
#  competition_scope_id :string(100)
#  duration_scope       :string(100)
#  scoping_label        :string(100)
#  site_scope           :string(100)
#

class StandingSubgroup < ActiveRecord::Base
    belongs_to :affiliation
    belongs_to :standing
end

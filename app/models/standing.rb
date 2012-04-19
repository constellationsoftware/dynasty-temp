# == Schema Information
#
# Table name: standings
#
#  id             :integer(4)      not null, primary key
#  affiliation_id :integer(4)      not null
#  standing_type  :string(100)
#  sub_season_id  :integer(4)      not null
#  last_updated   :string(100)
#  source         :string(100)
#

class Standing < ActiveRecord::Base
    belongs_to :affiliation
    belongs_to :sub_season
end

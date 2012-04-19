# == Schema Information
#
# Table name: dynasty_dollars
#
#  id      :integer(4)      not null, primary key
#  team_id :integer(4)      not null
#

class DynastyDollar < ActiveRecord::Base
    # TODO: associate with team, methods for income & expenses based on salaries, winnings, trade costs, etc.
    # TODO: views with line items of debits/credits?
end

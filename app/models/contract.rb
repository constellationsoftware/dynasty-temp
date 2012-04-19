# == Schema Information
#
# Table name: dynasty_player_contracts
#
#  id              :integer(4)      not null, primary key
#  created_at      :datetime
#  updated_at      :datetime
#  person_id       :integer(4)
#  amount          :integer(4)
#  length          :integer(4)
#  end_year        :integer(4)
#  summary         :integer(4)
#  free_agent_year :string(255)
#  bye_week        :integer(4)
#  depth           :string(255)
#

class Contract < ActiveRecord::Base
    self.table_name = 'dynasty_player_contracts'
    belongs_to :person

    def depth_formatted
        case depth.to_i
        when 1
            'starter'
        when 2
            'bench'
        when 3
            'reserve'
        else ''
        end
    end
end

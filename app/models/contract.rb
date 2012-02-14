class Contract < ActiveRecord::Base
    self.table_name 'dynasty_player_contracts'
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

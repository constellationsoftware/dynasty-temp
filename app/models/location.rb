class Location < ActiveRecord::Base
    has_one :address

    has_one :display_name,
            :foreign_key => 'entity_id',
            :conditions => ['entity_type = ?', 'locations']
end

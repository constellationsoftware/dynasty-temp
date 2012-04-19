# == Schema Information
#
# Table name: display_names
#
#  id           :integer(4)      not null, primary key
#  language     :string(100)     not null
#  entity_type  :string(100)     not null
#  entity_id    :integer(4)      not null
#  full_name    :string(100)
#  first_name   :string(100)
#  middle_name  :string(100)
#  last_name    :string(100)
#  alias        :string(100)
#  abbreviation :string(100)
#  short_name   :string(100)
#  prefix       :string(20)
#  suffix       :string(20)
#

class DisplayName < ActiveRecord::Base
    belongs_to :entity, :polymorphic => true

    def last_with_first_initial
        if self.first_name? && self.last_name?
            "#{first_name.first.capitalize}. #{last_name.capitalize}"
        else
            self.last_name? ? self.last_name : self.full_name
        end
    end
end

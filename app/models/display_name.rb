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

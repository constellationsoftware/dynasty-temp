class Message < ActiveRecord::Base

    def flatten
        {
            :id => self.id,
            :content => self.content
        }
    end
end

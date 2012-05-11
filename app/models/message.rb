# == Schema Information
#
# Table name: messages
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Message < ActiveRecord::Base

    def flatten
        {
            :id => self.id,
            :content => self.content
        }
    end
end

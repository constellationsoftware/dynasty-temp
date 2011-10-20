class Salary < ActiveRecord::Base
  belongs_to :person

  # Match salaries to persons through displayname
  def matcher
    if DisplayName.exists?(:full_name => self.full_name)
      @dn            = DisplayName.find_by_full_name(self.full_name)
      self.person_id = @dn.entity_id
      self.save
    end
  end

  def self.has_contract
  	where("contract_amount > ?", 0 )
  end

end

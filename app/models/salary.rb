class Salary < ActiveRecord::Base
  #include Sencha::Model
  class << self; attr_accessor :default_sort end
  @default_sort = 'contract_amount DESC'

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

  def self.default_sort
    DisplayName.order("contract_amount DESC")
  end

  # Sencha model fields
  #sencha_fields :exclude => [ :player_id ]
end

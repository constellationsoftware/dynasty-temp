class Salary < ActiveRecord::Base
  has_many :picks
  #include Sencha::Model
  POSITION_PRIORITIES = ['QB', 'WR', 'RB', 'TE', 'K']

  # Returns a case statement for ordering by a particular set of strings
  # Note that the SQL is built by hand and therefore injection is possible,
  # however since we're declaring the priorities in a constant above it's
  # safe.
  def self.order_by_position_priority
    ret = "CASE"
    POSITION_PRIORITIES.each_with_index do |p, i|
      ret << " WHEN SUBSTRING(position, 1, 2) = '#{p}' THEN #{i}"
    end
    ret << " END ASC"
  end

  def self.available
    @draft = Draft.last 
    @pickmap = @draft.picks.where("person_id >= ?", 1).map(&:person_id)
    @picked = Salary.find(@pickmap)
    Salary.all - @picked
  end
  #scopes
  scope :offense, where("SUBSTRING(position, 1, 2) IN (?)", POSITION_PRIORITIES)
  scope :by_position, order(order_by_position_priority)

  #belongs_to :person

  # Match salaries to persons through displayname
  #def matcher
  #  if DisplayName.exists?(:full_name => self.full_name)
  #    @dn            = DisplayName.find_by_full_name(self.full_name)
  #    self.person_id = @dn.entity_id
  #    self.save
  #  end
  #end

  #def self.has_contract
  #	where("contract_amount > ?", 0 )
  #end



  # Sencha model fields
  #sencha_fields :exclude => [ :player_id ]
end

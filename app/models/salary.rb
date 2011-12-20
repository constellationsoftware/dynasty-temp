class Salary < ActiveRecord::Base
  POSITION_PRIORITIES = ['QB', 'WR', 'RB', 'TE', 'K']

  has_many :picks, :foreign_key => :person_id
  belongs_to :person

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

  # scopes
  scope :by_position, Proc.new{ |filter = nil|
    if !(filter.nil?) and filter.size > 0
      filter = filter[0] # for now we're not supporting multiple filters
      where(filter['property'].to_sym => filter['value'].to_s)
    else
      where("SUBSTRING(position, 1, 2) IN (?)", POSITION_PRIORITIES)
        .order(order_by_position_priority)
    end
  }
  scope :with_valid, lambda {
    select('DISTINCT salaries.*, p.id IS NULL AS is_valid')
      .joins('LEFT OUTER JOIN picks p ON salaries.id = p.person_id')
  }
  scope :by_rating, order('points DESC')
  scope :available, joins('LEFT OUTER JOIN picks p ON salaries.id = p.person_id')
    .where('p.id IS NULL')
  scope :roster, lambda { |my_user|
    joins{picks.user}
      .where{picks.user.id.eq my_user.id}
  }


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

  def valid
    raise "Missing attribute" unless has_attribute?(:valid)
    !!read_attribute(:valid)
  end

  # Sencha model fields
  #sencha_fields :exclude => [ :player_id ]
end

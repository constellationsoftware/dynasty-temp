class UserTeam < ActiveRecord::Base
  set_table_name 'dynasty_teams'

  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :players
  has_one :balance,
    :class_name => 'UserTeamBalance',
    :autosave => true,
    :dependent => :destroy,
    :inverse_of => :team

  scope :online, self.where(:is_online => true)
  scope :offline, self.where(:is_online => false)

  before_create :generate_uuid
  after_create :initial_balance

  # @return [Object]
  # TODO The initial balance should be set by league settings
  def initial_balance
    self.create_balance
    self.balance.balance_cents = 7500000000
    self.balance.save
  end

  # aliased method overrides the default getter for the association
  # so we can return the balance attr of the associated class
  # instead of the class instance
  # hacky fix with addand
  #alias_method :get_balance_instance, :balance
  #def balance
  #  self.get_balance_instance.andand.balance
  #end

=begin
  def roster
    ld = self.league.drafts.last.picks.where("team_id = ?", self.id).map(&:person_id)
    salaries = Salary.find(ld)
    salaries
  end

  def payroll
    payroll = 0
    salaries = self.roster
    salaries.each do |salary|
      payroll += salary.contract_amount
    end
    payroll = payroll.to_f / 1000000
    payroll
    payroll = "$" + payroll.to_s + "MM"
  end
=end

  def is_offline
  	self.offline
  end

  # use uuid as a string
  def uuid
    parse_uuid_to_s
  end

  # convert a uuid to string
  def parse_uuid_to_s
    (self[:uuid].empty?) ? nil : UUIDTools::UUID.parse_raw(self[:uuid]).to_s
  end

  def self.find_by_uuid(uuid_s)
    uuid = UUIDTools::UUID.parse(uuid_s)
    raw = uuid.raw
    super(raw)
  end

 # requires :association, :user, :league
 # requires :attribute, :name

 	private
 		def generate_uuid
 			uuid = UUIDTools::UUID.timestamp_create
 			self.uuid = uuid.raw
 		end
end

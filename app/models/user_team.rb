class UserTeam < ActiveRecord::Base
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
  scope :draft_data, includes(:user, :picks)

  before_create :generate_uuid

  # aliased method overrides the default getter for the association
  # so we can return the balance attr of the associated class
  # instead of the class instance
  alias_method :get_balance_instance, :balance
  def balance
    return self.get_balance_instance.balance
  end

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

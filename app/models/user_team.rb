class UserTeam < ActiveRecord::Base
  set_table_name 'dynasty_teams'

  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :player_team_records, :conditions => 'current = TRUE'
  has_many :players, :through => :player_team_records
  money :balance, :cents => :balance_cents

  scope :online, where(:is_online => true)
  scope :offline, where(:is_online => false)

  def salary_total
    UserTeam.joins{picks.player.contract}
      .select{coalesce(sum(picks.player.contract.amount), 0).as('total')}
      .where{id == my{self.id}}.first.total.to_f
  end

  before_create :generate_uuid
  after_create :initial_balance_from_league

  # @return [Object]
  # TODO The initial balance should be set by league settings
  def initial_balance_from_league
    if !!self.league_id
      self.balance = self.league.default_balance
    else
      self.balance = 75000000
    end
    self.save
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

class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :players

  scope :online, self.where(:is_online => 1)
  scope :offline, self.where(:is_online => 0)

  def is_offline
  	self.offline
  end

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

 # requires :association, :user, :league
 # requires :attribute, :name
end

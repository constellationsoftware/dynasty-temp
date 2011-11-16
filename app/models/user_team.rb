class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :picks, :foreign_key => 'team_id'
  has_many :players

  scope :online, self.where(:is_online => true)
  scope :offline, self.where(:is_online => false)

  before_create :generate_uuid

  def is_offline
  	self.offline
  end

  def uuid
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

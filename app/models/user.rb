class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :roles, :email, :password, :password_confirmation, :remember_me, :last_seen, :id, :current_sign_in_at, :current_sign_in_ip
  # Include default devise modules. Others available are:
  #:token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable, :lastseenable

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :name
  has_many :teams, :class_name => 'UserTeam'
  has_many :leagues, :foreign_key => 'manager_id'


def roles=(roles)
  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
end

def roles
  ROLES.reject do |r|
    ((roles_mask || 0) & 2**ROLES.index(r)).zero?
  end
end

def is?(role)
  roles.include?(role.to_s)
end

end

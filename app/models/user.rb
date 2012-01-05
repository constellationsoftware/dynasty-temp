class User < ActiveRecord::Base
  set_table_name 'dynasty_users'
  
    
    
    ##Send welcome email after creation
    #require 'rest_client'
    #after_create :send_welcome_email
    #
    #private
    #
    #def send_welcome_email
    #  #send the welcome email
    #  require 'rest_client'
    #  RestClient.post 'https://api:key-8po38nxi-4-g6p8tx1zem4lnxzwlgh61@api.mailgun.net/v2',
    #                  :from => "developers@dynastyowner.net",
    #                  :to => "bamurphymac@me.com",
    #                  :subject => "Welcome to Dynasty Owner BETA.",
    #                  :text => "Your username is XYZ and your password is PQR",
    #                  :html => "Your username is <strong>XYZ</strong> and your password is <em>PQR!</em>"
    #end


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


#def current_team
#  Team.where(:user_id => current_user.id).where(:league_id => current_user.league_id)
#end

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

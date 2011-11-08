class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_seen, :id, :current_sign_in_at, :current_sign_in_ip
  # Include default devise modules. Others available are:
  #:token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable, :lastseenable

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :user_team
  has_many :leagues, :foreign_key => 'manager_id'
end

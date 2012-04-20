# == Schema Information
#
# Table name: dynasty_users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string(255)
#  last_seen              :datetime
#  first_name             :string(50)      not null
#  role                   :string(255)
#  roles_mask             :integer(4)
#  phone                  :string(32)
#  last_name              :string(50)      not null
#

class User < ActiveRecord::Base
	rolify
    self.table_name = 'dynasty_users'



    # Include default devise modules. Others available are:
    #:token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable, :lastseenable


    include Gravtastic
    has_gravatar :rating => 'R', :default => 'mm', :secure => false

    # not sure if a new column is needed for this
    alias_attribute :persistence_token, :authentication_token

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
    # has_and_belongs_to_many :roles

    # Setup accessible (or protected) attributes for your model

    #has_many :teams
    has_one :team
    has_many :leagues, :foreign_key => 'manager_id'
    has_one  :address, :class_name => 'UserAddress', :dependent => :destroy
    has_many :event_subscriptions, :class_name => 'DynastyEventSubscription'
    has_many :events, :through => :event_subscriptions

    attr_accessible :roles, :email, :password, :password_confirmation, :remember_me, :last_seen, :id, :current_sign_in_at, :current_sign_in_ip, :phone, :area_code, :notifications, :first_name, :last_name, :address_attributes, :event_subscriptions_attributes, :address
    accepts_nested_attributes_for :address
    accepts_nested_attributes_for :event_subscriptions, :reject_if => lambda{ |attributes|
        attributes.all?{ |k,v| v.blank? }
    }

    scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
    scope :with_address, joins{ address }.includes{ address }

    validates_presence_of :first_name, :last_name

    # ALWAYS add new roles add the end of this list
    ROLES = %w[admin user team_owner league_founder league_commissioner banker]

    def roles=(roles)
        self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
    end

   def team_league
     team.league
   end

    def roles
        ROLES.reject do |r|
            ((roles_mask || 0) & 2**ROLES.index(r)).zero?
        end
    end

    def is?(role)
        roles.include?(role.to_s)
    end

    def role_symbols
        roles.map(&:to_sym)
    end

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end

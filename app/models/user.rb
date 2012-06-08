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
require 'digest/md5'

class User < ActiveRecord::Base
    self.table_name = 'dynasty_users'
    before_save { |user| user.email = email.downcase }
    rolify

    # Include default devise modules. Others available are:
    #:token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable, :lastseenable, :expirable, :authentication_keys => [:login]

    include Gravtastic
    has_gravatar :rating => 'R', :default => 'mm', :secure => false

    # login via username of email
    attr_accessor :login

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

    #has_many :teams
    has_one :team
    has_many :leagues, :foreign_key => 'manager_id'
    has_one :address, :class_name => 'UserAddress', :dependent => :destroy
    has_many :event_subscriptions, :class_name => 'DynastyEventSubscription'
    has_many :events, :through => :event_subscriptions
    has_one :invitation, :class_name => 'User', :as => :invited_by

    attr_accessible :roles, :email, :username, :login, :password, :password_confirmation, :remember_me, :last_seen, :id, :current_sign_in_at, :current_sign_in_ip, :phone, :area_code, :notifications, :first_name, :last_name, :address_attributes, :event_subscriptions_attributes, :address

    accepts_nested_attributes_for :address

    accepts_nested_attributes_for :event_subscriptions, :reject_if => lambda { |attributes|
        attributes.all? { |k, v| v.blank? }
    }

    scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
    scope :with_address, joins { address }.includes { address }

    validates_presence_of :first_name, :last_name
    validates_uniqueness_of :email, :username

    def gravatar_profile
        hash = Digest::MD5.hexdigest(self.email)
        return "http://gravatar.com/#{hash}"
    end

    def full_name;
        "#{self.first_name} #{self.last_name}"
    end

    def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
            where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
        else
            where(conditions).first
        end
    end
end

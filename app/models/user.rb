class User < ActiveRecord::Base
    self.table_name = 'dynasty_users'

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
    # Include default devise modules. Others available are:
    #:token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable, :lastseenable

    has_many :teams, :class_name => 'UserTeam'
    has_many :leagues, :foreign_key => 'manager_id'
    has_one  :address, :class_name => 'UserAddress', :dependent => :destroy
    has_many :event_subscriptions, :class_name => 'DynastyEventSubscription'
    has_many :events, :through => :event_subscriptions

    attr_accessible :roles, :email, :password, :password_confirmation, :remember_me, :last_seen, :id, :current_sign_in_at, :current_sign_in_ip, :phone, :area_code, :notifications, :first_name, :last_name, :address_attributes, :event_subscriptions_attributes
    accepts_nested_attributes_for :address
    accepts_nested_attributes_for :event_subscriptions, :reject_if => lambda{ |attributes|
        attributes.all?{ |k,v| v.blank? }
    }

    scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
    scope :with_address, joins{ address }.includes{ address }

    validates_presence_of :first_name, :last_name

    # ALWAYS add new roles add the end of this list
    ROLES = %w[admin user team_owner league_founder league_commissioner]

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

    def role_symbols
        roles.map(&:to_sym)
    end
end

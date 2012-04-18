class PlayerTeam < ActiveRecord::Base
    self.table_name = 'dynasty_player_teams'

    belongs_to :player
    belongs_to :position
    belongs_to :team
    has_one :league, :through => :team
    belongs_to :lineup, :class_name => '::Lineup'
    has_one :league, :through => :team
    has_many :receipts, :class_name => 'PlayerAccount', :as => :payable

    # shortcut associations that bypass the person table (actual person data is seldom useful)
    has_one :player_name,
        :class_name => 'DisplayName',
        :primary_key => 'player_id',
        :foreign_key => 'entity_id',
        :conditions => { :entity_type => 'persons' }
    has_one :player_contract,
        :class_name => 'Contract',
        :primary_key => :player_id,
        :foreign_key => :person_id
    has_one :player_points,
        :class_name => 'PlayerPoint',
        :primary_key => :player_id,
        :foreign_key => :player_id
    has_many :player_event_points,
        :primary_key => :player_id,
        :foreign_key => :player_id

    #attr_accessible :team, :league, :player, :lineup
    validates_with Validators::PlayerTeam, :on => :update

    scope :has_depth, lambda{ |d| where{ depth == my{ d } } }
    scope :on_waiver_wire, where{ waiver == 1 }
    scope :starter, where{ lineup_id >= 1 }
    scope :bench, where{ lineup_id == nil }


    scope :with_player_name, joins{ player_name }.includes{ player_name }
    scope :with_player_contract, joins{ player_contract }.includes{ player_contract }
    scope :with_position, joins{ position }.includes{ position }
    scope :with_player_points, joins{ player_points }.includes{ player_points }

    def name
        self.player.name.full_name
    end

    def guaranteed_remaining
        contract = self.player.contract
        return 0 if contract.guaranteed.nil? || contract.guaranteed === 0
        # assume this player's been paid in full up to this season
        seasonal_sum = (Season.current.year + contract.length - contract.end_year) * contract.amount
        return 0 unless seasonal_sum < contract.guaranteed

        # compute the total salary disbursed this season
        payroll_transactions = PlayerAccount.transactions_this_season.where{ receivable_id == my{ self.id } }
        paid_sum = payroll_transactions.nil? ? 0 : payroll_transactions.inject(0.to_money) do |sum, transaction|
            sum += transaction.amount
        end
        total = paid_sum + seasonal_sum.to_money
        (total < contract.guaranteed.to_money) ? contract.guaranteed.to_money - total : 0
    end
    def guaranteed_remaining?; guaranteed_remaining > 0 end
end

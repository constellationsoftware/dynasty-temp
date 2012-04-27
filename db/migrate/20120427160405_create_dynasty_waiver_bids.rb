class CreateDynastyWaiverBids < ActiveRecord::Migration
  def up
    create_table :dynasty_waiver_bids do |t|
      t.integer       :waiver_id
      t.integer       :team_id
      t.integer       :bid_cents
      t.timestamps
    end

    add_index :dynasty_waiver_bids, [ :team_id, :waiver_id ], :name => 'index_dynasty_waiver_bids_on_teams'
  end

  def down
    drop_table :dynasty_waiver_bids
  end
end

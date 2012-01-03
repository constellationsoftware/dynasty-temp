class AddIndicesToDynastyDraftPicks < ActiveRecord::Migration
  def change
    add_index(:dynasty_draft_picks, :player_id)
    add_index(:dynasty_draft_picks, :draft_id)
    add_index(:dynasty_draft_picks, :team_id)
  end
end

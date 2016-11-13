class CreateProposalsData < ActiveRecord::Migration
  def change
    create_table :proposals_data do |t|
      t.integer :max_proposals_count
      t.date :deadline

      t.timestamps null: false
    end
  end
end

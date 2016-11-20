class AddWinnerProposalIdToProposalsData < ActiveRecord::Migration
  def change
    add_column :proposals_data, :winner_proposal_id, :integer
  end
end

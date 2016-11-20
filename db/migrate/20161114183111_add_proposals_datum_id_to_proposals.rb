class AddProposalsDatumIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :proposals_datum_id, :integer
  end
end

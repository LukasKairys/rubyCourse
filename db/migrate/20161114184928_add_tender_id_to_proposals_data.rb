class AddTenderIdToProposalsData < ActiveRecord::Migration
  def change
    add_column :proposals_data, :tender_id, :integer
  end
end

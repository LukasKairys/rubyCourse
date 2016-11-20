class AddTenderIdToShipmentTenderData < ActiveRecord::Migration
  def change
    add_column :shipment_tender_data, :tender_id, :integer
  end
end

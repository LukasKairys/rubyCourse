class AddShipmentTenderDatumIdToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :shipment_tender_datum_id, :integer
  end
end

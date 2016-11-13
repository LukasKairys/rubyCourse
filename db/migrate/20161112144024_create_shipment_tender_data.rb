class CreateShipmentTenderData < ActiveRecord::Migration
  def change
    create_table :shipment_tender_data do |t|
      t.string :type
      t.string :name
      t.integer :route_id

      t.timestamps null: false
    end
  end
end

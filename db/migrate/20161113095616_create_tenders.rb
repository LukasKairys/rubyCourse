class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.integer :shipment_tender_data_id
      t.integer :proposals_data_id

      t.timestamps null: false
    end
  end
end

class FixTenderType < ActiveRecord::Migration
  def change
    rename_column :shipment_tender_data, :type, :shipment_type
  end
end

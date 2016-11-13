class CreateDataStorages < ActiveRecord::Migration
  def change
    create_table :data_storages do |t|

      t.timestamps null: false
    end
  end
end

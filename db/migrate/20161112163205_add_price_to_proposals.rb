class AddPriceToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :price, :float
  end
end

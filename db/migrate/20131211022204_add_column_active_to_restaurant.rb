class AddColumnActiveToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :active, :boolean, default: false
  end
end

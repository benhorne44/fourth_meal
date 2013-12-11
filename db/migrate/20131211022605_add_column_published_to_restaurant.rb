class AddColumnPublishedToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :published, :boolean, default: false
  end
end

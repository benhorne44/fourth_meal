class ChangePriceFormatForItems < ActiveRecord::Migration
  def self.up
    change_column :items, :price, :integer
  end

  def self.down
    change_column :items, :price, :decimal
  end
end

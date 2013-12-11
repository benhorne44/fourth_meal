class AddColumnZipcodToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :zipcode, :integer
  end
end

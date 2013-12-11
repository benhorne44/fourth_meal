class AddObscureIdentifierToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :obscure_identifier, :string
  end
end

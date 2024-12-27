class AddIndexToOrders < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!
  def change
    add_index :orders, :product_id, algorithm: :concurrently
  end
end

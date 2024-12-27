class AddFnIndexToOrders < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!
  def change
    add_index :orders, 'DATE(created_at)', name: 'index_orders_on_created_at_date', algorithm: :concurrently
  end
end

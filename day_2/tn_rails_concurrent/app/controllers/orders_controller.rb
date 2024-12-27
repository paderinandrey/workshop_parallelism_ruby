# frozen_string_literal: true
class OrdersController < ApplicationController
  def top_products_report
    top_products = Order
      .with(
        daily_orders: Order
          .select('product_id, DATE(created_at) AS order_date, SUM(quantity) AS total_quantity')
          .group('product_id, DATE(created_at)'),
      )
      .from('daily_orders AS d')
      .joins(<<~SQL.squish)
        LEFT JOIN products AS p ON d.product_id = p.id
          AND d.total_quantity = p.orders_count
      SQL
      .select('d.order_date, d.product_id, d.total_quantity')
      .order(total_quantity: :desc )
      .limit(10)
      .map do |row|
        {
          date:           row.order_date,
          product_id:     row.product_id,
          total_quantity: row.total_quantity,
        }
      end

    render json: top_products
  end
end

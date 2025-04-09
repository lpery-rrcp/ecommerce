class CheckoutsController < ApplicationController
  def create
    @order = cuttent_user.orders.create(status: :pending)
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create!(
        product: product,
        quantity: quantity,
        unit_price: product.price
      )
    end
    @order.update(total_price: @order.order_items.sum { |i| i.quantity * i.unit_price })
    session[:cart] = {}
    redirect_to success_cart_path
  end
end

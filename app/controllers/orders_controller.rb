class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @items = []
    cart = session[:cart] || {}

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      @items << {
        product: product,
        quantity: quantity.to_i,
        total_price: product.price * quantity.to_i
      }
    end

    @total = @items.sum { |item| item[:total_price] }
  end

  def create
    # This will eventually create the order + order_items
    # We’ll fill this in next
    render plain: "Order will be placed here (to be implemented)"
  end
end

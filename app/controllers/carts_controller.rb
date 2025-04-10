class CartsController < ApplicationController
  def show
    cart = session[:cart] || {}
    @items = []

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

  def add
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] = (session[:cart][product_id] || 0) + 1
    flash[:notice] = "Added to cart!"
    redirect_back fallback_location: root_path
  end

  def remove
    session[:cart]&.delete(params[:product_id].to_s)
    flash[:alert] = "Item removed."
    redirect_to cart_path
  end

  def update
    product_id = params[:product_id].to_s
    new_qty = params[:quantity].to_i
    if new_qty > 0
      session[:cart][product_id] = new_qty
    else
      session[:cart].delete(product_id)
    end
    flash[:notice] = "Cart updated."
    redirect_to cart_path
  end

  def success; end
  def cancel; end
end

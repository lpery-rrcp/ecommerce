class CartsController < ApplicationController
  def success
    session[:cart] ||= {}
  end

  def cancel
    if session[:cart].include?(@product.id)
      session[:cart].delete(@product.id)
      flash[:notice] = "#{@product.name} was removed from the cart!"
    end

    redirect_to root_path
  end

  private

  def add_to_cart(product_id, quantity = 1)
    cart = current_cart
    cart[product_id.to_s] = (cart[product_id.to_s] || 0) + quantity.to_i
    session[:cart] = cart
  end

  def removed_from_cart(product_id)
    cart = current_cart
    cart.delete(product_id.to_s)
    session[:cart] = cart
  end
end

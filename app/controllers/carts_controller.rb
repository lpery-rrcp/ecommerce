class CartsController < ApplicationController
  before_action :authenticate_user!, only: [ :success ]

  def add
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] = (session[:cart][product_id] || 0) + 1
    flash[:notice] = "Product added to cart!"
    redirect_back fallback_location: root_path
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity if quantity > 0
    flash[:notice] = "Quantity updated!"
    redirect_back fallback_location: root_path
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)
    flash[:alert] = "Product removed from cart."
    redirect_back fallback_location: root_path
  end

  def success
    flash[:success] = "Thank you! Your order was successful. :)"
  end

  def cancel
    flash[:alert] = "Your checkout was canceled!"
  end
end

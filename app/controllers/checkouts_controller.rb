class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    order = current_user.orders.build(status: :pending)

    total = 0
    session[:cart].each do |product_id, qty|
      product = Product.find(product_id)
      subtotal = product.price * qty.to_i
      order.order_items.build(product: product, quantity: qty, unit_price: product.price)
      total += subtotal
    end

    tax = calculate_tax(total)
    order.total_price = total + tax[:total_tax]
    order.save!

    Payment.create!(
      order: order,
      user: current_user,
      amount: order.total_price,
      status: :completed,
      payment_method: :credit_card
    )

    session[:cart] = {}
    redirect_to success_cart_path
  end

  private

  def calculate_tax(amount)
    province = current_user.province
    gst = amount * (province.gst || 0)
    pst = amount * (province.pst || 0)
    hst = amount * (province.hst || 0)
    { gst: gst, pst: pst, hst: hst, total_tax: gst + pst + hst }
  end
end

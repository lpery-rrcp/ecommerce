class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = session[:cart] || {}
    raise "Cart is empty" if cart.empty?

    line_items = cart.map do |product_id, quantity|
      product = Product.find(product_id)
      {
        price_data: {
          currency: "usd",
          unit_amount: (product.price * 100).to_i,
          product_data: {
            name: product.name
          }
        },
        quantity: quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      customer_email: current_user.email,
      line_items: line_items,
      mode: "payment",
      success_url: success_url,
      cancel_url: cancel_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
    cart = session[:cart] || {}
    return redirect_to root_path, alert: "Cart is empty." if cart.empty?

    if current_user.province.nil?
      return redirect_to edit_profile_path, alert: "Please complete your address to calculate taxes."
    end

    province = current_user.province
    order = current_user.orders.build(status: :paid, customer_id: current_user.id)


    subtotal = 0

    cart.each do |product_id, qty|
      product = Product.find(product_id)
      subtotal += product.price * qty.to_i
      order.order_items.build(product: product, quantity: qty, unit_price: product.price)
    end

    tax_details = province.calculate_tax(subtotal)
    order.total_price = (subtotal + tax_details[:total_tax]).round
    order.save!

    Payment.create!(
      order: order,
      user: current_user,
      amount: order.total_price,
      status: :completed,
      payment_method: :credit_card
    )

    session[:cart] = {}
    flash[:notice] = "✅ Payment successful!"
    redirect_to orders_path
  end


  def cancel
    flash[:alert] = "Payment canceled."
    redirect_to cart_path
  end

  private

  def calculate_tax(total)
    province = current_user.province
    gst = (total * province.gst.to_f).round(2)
    pst = (total * province.pst.to_f).round(2)
    hst = (total * province.hst.to_f).round(2)

    {
      gst: gst,
      pst: pst,
      hst: hst,
      total_tax: (gst + pst + hst).round(2)
    }
  end
end

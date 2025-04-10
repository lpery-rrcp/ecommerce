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

    order = current_user.orders.build(status: :paid)
    total = 0

    cart.each do |product_id, qty|
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
    flash[:notice] = "✅ Payment successful!"
    redirect_to orders_path
  end

  def cancel
    flash[:alert] = "Payment canceled."
    redirect_to cart_path
  end

  private

  def calculate_tax(total)
    # Define your tax calculation logic here
    tax_rate = 0.10  # For example, 10% tax rate
    total_tax = total * tax_rate
    { total_tax: total_tax }
  end
end

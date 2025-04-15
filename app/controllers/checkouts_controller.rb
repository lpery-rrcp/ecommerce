class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = session[:cart] || {}
    raise "Cart is empty" if cart.empty?

    province = current_user.province
    raise "Missing address" if province.nil?

    subtotal = 0
    line_items = cart.map do |product_id, quantity|
      product = Product.find(product_id)
      subtotal += product.price * quantity.to_i

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

    # Calculate tax and add as a separate line item
    tax = TaxCalculator.calculate_tax(subtotal, province)
    total_tax = tax[:total_tax]

    line_items << {
      price_data: {
        currency: "usd",
        unit_amount: (total_tax * 100).to_i,
        product_data: {
          name: "Sales Tax"
        }
      },
      quantity: 1
    }

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

    tax_details = TaxCalculator.calculate_tax(subtotal, province)
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
end

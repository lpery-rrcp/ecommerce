ActiveAdmin.register Order do
  includes :user, order_items: :product

  # Only allow editing of status and user (not taxes or totals)
  permit_params :status, :user_id

  index title: "All Customer Orders" do
    selectable_column
    id_column
    column :user
    column "Items" do |order|
      ul do
        order.order_items.each do |item|
          li "#{item.product.name} - Qty: #{item.quantity} - Unit Price: #{number_to_currency(item.unit_price)}"
        end
      end
    end

    column("Subtotal (pre-tax)") do |order|
      subtotal = order.order_items.sum { |item| item.unit_price * item.quantity }
      number_to_currency(subtotal)
    end

    column("GST") { |order| number_to_currency(order.user.province.gst * order.total_price) }
    column("PST") { |order| number_to_currency(order.user.province.pst * order.total_price) }
    column("HST") { |order| number_to_currency(order.user.province.hst * order.total_price) }

    column :total_price do |order|
      number_to_currency(order.total_price)
    end

    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :status
      row :created_at
      row :updated_at

      row("Items") do |order|
        ul do
          order.order_items.each do |item|
            li "#{item.product.name} - Qty: #{item.quantity} - Unit Price: #{number_to_currency(item.unit_price)}"
          end
        end
      end

      row("Subtotal (pre-tax)") { number_to_currency(order.order_items.sum { |item| item.unit_price * item.quantity }) }
      row("GST") { number_to_currency(order.user.province.gst * order.total_price) }
      row("PST") { number_to_currency(order.user.province.pst * order.total_price) }
      row("HST") { number_to_currency(order.user.province.hst * order.total_price) }
      row("Total Price") { number_to_currency(order.total_price) }
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :user
      f.input :status
    end
    f.actions
  end
end

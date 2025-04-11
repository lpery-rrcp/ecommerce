ActiveAdmin.register Order do
  permit_params :status, :total_price, :user_id

  # Customize the form and actions
  form do |f|
    f.inputs "Order Details" do
      f.input :status
      f.input :total_price
      f.input :user
    end
    f.actions
  end
end

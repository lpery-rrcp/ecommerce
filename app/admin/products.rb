ActiveAdmin.register Product do
  permit_params :name, :description, :category_id, :price, :stock_quantity, :seller_id, :image, :on_sale
  # 🔼 Added `:on_sale` to permit_params

  remove_filter :image_attachment, :image_blob

  index do
    selectable_column
    column :name
    column :price
    column :stock_quantity
    column :on_sale # Optionally display on_sale status
    column :category
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :category
      f.input :price
      f.input :stock_quantity
      f.input :seller
      f.input :image, as: :file
      f.input :on_sale # 🔼 Add this input field to the form
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :on_sale
      row :category
      row :image do |product|
        image_tag product.image if product.image.attached?
      end
    end
  end
end

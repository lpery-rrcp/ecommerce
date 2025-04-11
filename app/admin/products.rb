ActiveAdmin.register Product do
  permit_params :name, :description, :category_id, :price, :stock_quantity, :seller_id, :image

  # Remove the invalid filter for :image
  # filter :image

  # Custom filter to check if an image is attached
  remove_filter :image_attachment, :image_blob

  # Other admin configuration
  index do
    selectable_column
    column :name
    column :price
    column :stock_quantity
    column :category
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :image do |product|
        image_tag product.image if product.image.attached?
      end
    end
  end
end

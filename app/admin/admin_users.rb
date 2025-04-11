# app/admin/products.rb
ActiveAdmin.register Product do
  permit_params :name, :price, :description, :image # Add any other fields

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :description
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), style: "max-width: 200px;"
        else
          "No Image"
        end
      end
    end
  end
end

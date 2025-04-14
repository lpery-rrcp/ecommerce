ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :address, :city, :province_id

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :address
    column :city
    column("Province") { |user| user.province&.name }
    column :created_at
    actions
  end

  filter :email
  filter :role, as: :select, collection: User.roles.keys
  filter :province

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: User.roles.keys
      f.input :address
      f.input :city
      f.input :province
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :role
      row :address
      row :city
      row("Province") { |user| user.province&.name }
      row :created_at
      row :updated_at
    end
  end
end

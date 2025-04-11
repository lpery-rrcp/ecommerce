ActiveAdmin.register Order do
  # Customize the index page here
  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :status
    column :created_at
    actions
  end

  # Show details for each order
  show do
    attributes_table do
      row :user
      row :total_price
      row :status
      row :created_at
      row :updated_at
      # Add more details if needed
    end
    active_admin_comments
  end

  # Add filters if needed
  filter :status
  filter :created_at
  filter :user
end

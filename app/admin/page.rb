ActiveAdmin.register Page do
  permit_params :title, :slug, :content

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :content, as: :quill_editor  # if using ActiveAdminQuillEditor or switch to :text
    end
    f.actions
  end
end

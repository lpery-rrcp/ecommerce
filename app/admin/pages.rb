ActiveAdmin.register Page do
  permit_params :title, :slug, :content

  form do |f|
    f.inputs "Edit Page" do
      f.input :title
      f.input :slug, input_html: { disabled: f.object.persisted? } # prevent changing slug
      f.input :content, as: :text, input_html: { rows: 15 }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        simple_format page.content
      end
    end
  end
end

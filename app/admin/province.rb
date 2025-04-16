ActiveAdmin.register Province do
  # Make the page read-only (no creation or editing)
  actions :index, :show

  index title: "Provinces and Tax Rates" do
    selectable_column
    id_column
    column :name
    column("GST") { |province| number_to_percentage(province.gst * 100, precision: 2) }
    column("PST") { |province| number_to_percentage(province.pst * 100, precision: 2) }
    column("HST") { |province| number_to_percentage(province.hst * 100, precision: 2) }
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :id
      row :name
      row("GST") { number_to_percentage(province.gst * 100, precision: 2) }
      row("PST") { number_to_percentage(province.pst * 100, precision: 2) }
      row("HST") { number_to_percentage(province.hst * 100, precision: 2) }
      row :created_at
      row :updated_at
    end
  end
end

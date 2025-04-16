# app/helpers/breadcrumbs_helper.rb
module BreadcrumbsHelper
  def render_breadcrumbs
    content_tag(:nav, class: "breadcrumb") do
      safe_join(breadcrumb_items, " &raquo; ".html_safe)
    end
  end

  private

  def breadcrumb_items
    crumbs = []
    crumbs << link_to("Home", root_path)

    case controller_name
    when "categories"
      if action_name == "index"
        crumbs << "Categories"
      elsif action_name == "show"
        crumbs << link_to("Categories", categories_path)
        crumbs << @category.name
      end

    when "products"
      if action_name == "index"
        crumbs << "Products"
      elsif action_name == "show"
        if @product.category
          crumbs << link_to("Categories", categories_path)
          crumbs << link_to(@product.category.name, category_path(@product.category))
        end
        crumbs << @product.name
      end

    when "pages"
      crumbs << @page.title if action_name == "show"

    end

    crumbs
  end
end

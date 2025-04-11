class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])

    # Get the products of the selected category
    @products = @category.products

    # If there's a search keyword, filter the products by name or description
    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Paginate the products
    @products = @products.page(params[:page]).per(10)
  end
end

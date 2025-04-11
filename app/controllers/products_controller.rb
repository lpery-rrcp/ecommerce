class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])

    # If there's a category filter, filter by it
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end

    # If a search keyword is provided, filter by name or description
    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(1) # Switch it to 5 later
  end
end

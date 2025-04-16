class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    # Search by keyword
    if params[:search].present?
      keyword = params[:search].downcase
      @products = @products.where(
        "LOWER(name) LIKE ? OR LOWER(description) LIKE ?",
        "%#{keyword}%",
        "%#{keyword}%"
      )
    end

    # Filter by category
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Apply the filters based on the params[:filter]
    if params[:filter] == "on_sale"
      @products = @products.where(on_sale: true)
    elsif params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ?", 3.days.ago).where.not("created_at >= ?", 3.days.ago)
    end

    # Paginate the results
    @products = @products.includes(:category).page(params[:page]).per(10)
  end

  def show
    @product = Product.includes(:category).find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(1)
  end
end

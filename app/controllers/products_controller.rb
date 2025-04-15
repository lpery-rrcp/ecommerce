class ProductsController < ApplicationController
  def index
    @categories = Category.all

    @products = Product.all

    if params[:search].present?
      keyword = params[:search].downcase
      @products = @products.where(
        "LOWER(name) LIKE ? OR LOWER(description) LIKE ?",
        "%#{keyword}%",
        "%#{keyword}%"
      )
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.includes(:category).page(params[:page]).per(10)
    @q = Product.ransack(params[:q])
    products_scope = @q.result.includes(:category)

    if params[:filter] == "on_sale"
      products_scope = products_scope.where(on_sale: true)
    elsif params[:filter] == "new"
      products_scope = products_scope.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recently_updated"
      products_scope = products_scope.where("updated_at >= ?", 3.days.ago).where.not("created_at >= ?", 3.days.ago)
    end

    @products = products_scope.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(1) # Switch it to 5 later
  end
end

class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products

    if params[:search].present?
      keyword = params[:search].downcase
      @products = @products.where(
        "LOWER(name) LIKE ? OR LOWER(description) LIKE ?",
        "%#{keyword}%",
        "%#{keyword}%"
      )
    end

    @products = @products.page(params[:page]).per(10)
  end
end

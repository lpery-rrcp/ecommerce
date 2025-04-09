class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end

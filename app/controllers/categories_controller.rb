class CategoriesController < ApplicationController
  def show
    @Category = Category.find(params[:id])
    @roducts = @category.products.page(params[:page])
  end
end

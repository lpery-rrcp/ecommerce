class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:review][:product_id])
    review = product.reviews.build(review_params.merge(user: current_user))
    if review.save
      flash[:notice] = "Thanks for the review."
    else
      flash[:alert] = "error in posting the review!"
    end
    redirect_to product_path(product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

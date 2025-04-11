class ReviewsController < ApplicationController
  # Only protect the create action (since it's the only one you have)
  before_action :authenticate_user!, only: [ :create ]

  def create
    Rails.logger.debug "Received parameters: #{params.inspect}"
    product = Product.find(params[:product_id])
    review = product.reviews.build(review_params.merge(user: current_user))

    if review.save
      flash[:notice] = "Thanks for the review."
    else
      flash[:alert] = "Failed to post the review."
    end

    redirect_to product_path(product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

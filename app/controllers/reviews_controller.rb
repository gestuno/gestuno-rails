class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def new
    @interpreter = User.find(params[:interpreter_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # we need `restaurant_id` to asssociate review with corresponding restaurant
    @review.interpreter = User.find(params[:interpreter_id])
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end

class ReviewsController < ApplicationController

  def edit
    @review = Review.find_by(book_id: params[:id])
  end

  def update
    @review = Review.find_by(book_id: params[:id])
    if @review.update(update_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:review).permit(:content).merge(book_id: params[:id])
  end
end

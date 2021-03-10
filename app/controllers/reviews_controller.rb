class ReviewsController < ApplicationController
  before_action :move_to_signup
  before_action :set_params
  before_action :move_to_top

  def edit
  end

  def update
    if @review.update(update_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:review).permit(:content).merge(book_id: params[:book_id])
  end

  def move_to_signup
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_params
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
  end

  def move_to_top
    redirect_to root_path if @book.id != @review.book_id
  end

end

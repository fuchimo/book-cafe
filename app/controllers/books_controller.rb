class BooksController < ApplicationController

  def index
    @books = Book.includes(:user)
  end

  def new
    @book_review = BookReview.new
  end

  def create
    @book_review = BookReview.new(book_params)
    if @book_review.valid?
      @book_review.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  private

  def book_params
    params.require(:book_review).permit(:title, :author, :publisher, :category_id, :image, :content).merge(user_id: current_user.id)
  end

end

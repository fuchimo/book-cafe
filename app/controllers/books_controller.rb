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

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(update_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book_review).permit(:title, :author, :publisher, :category_id, :image, :content).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:book).permit(:title, :author, :publisher, :category_id, :image).merge(user_id: current_user.id)
  end

end

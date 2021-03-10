class BooksController < ApplicationController
  before_action :move_to_signup, except: [:index, :show, :search, :category_search]
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :different_user_redirect, only: [:edit, :update, :destroy]

  def index
    @books = Book.includes(:user)
    @comments = Comment.all
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
  end

  def update
    if @book.update(update_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def show
    @review = @book.review.id
    @comment = Comment.new
    @comments = @book.comments.includes(:user)
  end

  def search
    @books = Book.search(params[:keyword])
    @comments = Comment.all
  end

  def category_search
    @books = Book.where(category_id: params[:category_id])
    @category = Category.find(params[:category_id])
    @comments = Comment.all
  end

  private

  def book_params
    params.require(:book_review).permit(:title, :author, :publisher, :category_id, :image, :content).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:book).permit(:title, :author, :publisher, :category_id, :image).merge(user_id: current_user.id)
  end

  def move_to_signup
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_params
    @book = Book.find(params[:id])
  end

  def different_user_redirect
    redirect_to root_path if current_user.id != @book.user_id
  end

end

class UsersController < ApplicationController
  before_action :move_to_signup

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @address = @user.address.id
    favorites = Favorite.where(user_id: @user.id).pluck(:book_id)
    @favorites = Book.find(favorites)
  end

  private

  def move_to_signup
    redirect_to new_user_session_path unless user_signed_in?
  end

end

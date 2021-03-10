class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @books = current_user.books

    favorites = Favorite.where(user_id: current_user.id).pluck(:book_id)
    @favorites = Book.find(favorites)
  end

end

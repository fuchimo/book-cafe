class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.create(book_id: params[:book_id])
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.destroy
    @book = Book.find(params[:book_id])
  end
  
end

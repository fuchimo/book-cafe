class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @books = current_user.books
  end

end

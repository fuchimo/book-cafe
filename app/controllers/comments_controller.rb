class CommentsController < ApplicationController
  before_action :set_params

  def create
    @comment = @book.comments.build(comment_params)
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, book_id: params[:book_id])
  end

  def set_params
    @book = Book.find(params[:book_id])
  end

end

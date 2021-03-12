require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  context 'コメントの投稿ができる時' do
    it 'すべての値が正しく入力されていれば投稿ができる' do
      expect(@comment).to be_valid
    end
  end

  context 'コメントの投稿ができない時' do
    it 'コメントが空だと投稿ができない' do
      @comment.comment = ''
      @comment.valid? 
      expect(@comment.errors.full_messages).to include "Comment can't be blank"
    end

    it 'user_idが紐づいていないと投稿ができない' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include "User must exist"
    end

    it 'book_idが紐づいていないと投稿ができない' do
      @comment.book = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include "Book must exist"
    end
  end
end

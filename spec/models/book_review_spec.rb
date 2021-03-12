require 'rails_helper'

RSpec.describe BookReview, type: :model do
  before do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    @book_review = FactoryBot.build(:book_review, user_id: user.id, book_id: book.id, image: book.image)
    sleep(0.5)
  end

  context '本の登録ができる時' do
    it 'すべての値が正しく入力されていれば登録ができる' do
      expect(@book_review).to be_valid
    end
  end

  context '本の登録ができない時' do
    it '画像が空だと登録ができない' do
      @book_review.image = nil
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Image can't be blank"
    end

    it 'タイトルが空だと登録ができない' do
      @book_review.title = ''
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Title can't be blank"
    end

    it '著者が空だと登録ができない' do
      @book_review.author = ''
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Author can't be blank"
    end

    it '出版社が空だと登録ができない' do
      @book_review.publisher = ''
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Publisher can't be blank"
    end

    it 'カテゴリーが空だと登録ができない' do
      @book_review.category_id = ''
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Category is Unselected"
    end

    it 'レビューが空だと登録ができない' do
      @book_review.content = ''
      @book_review.valid? 
      expect(@book_review.errors.full_messages).to include "Content can't be blank"
    end
  end

  it 'user_idが空だと登録ができない' do
    @book_review.user_id = ''
    @book_review.valid?
    expect(@book_review.errors.full_messages).to include "User can't be blank"
  end

  it 'book_idが空だと登録ができない' do
    @book_review.book_id = ''
    @book_review.valid?
    expect(@book_review.errors.full_messages).to include "Book can't be blank"
  end
end

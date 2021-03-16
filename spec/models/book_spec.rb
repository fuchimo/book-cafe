require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  context '本の編集ができる時' do
    it 'すべての値が正しく入力されていれば編集ができる' do
      expect(@book).to be_valid
    end
  end

  context '本の編集ができない時' do
    it '画像が空だと編集ができない' do
      @book.image = nil
      @book.valid? 
      expect(@book.errors.full_messages).to include "Image can't be blank"
    end

    it 'タイトルが空だと編集ができない' do
      @book.title = ''
      @book.valid? 
      expect(@book.errors.full_messages).to include "Title can't be blank"
    end

    it '著者が空だと編集ができない' do
      @book.author = ''
      @book.valid? 
      expect(@book.errors.full_messages).to include "Author can't be blank"
    end

    it '出版社が空だと編集ができない' do
      @book.publisher = ''
      @book.valid? 
      expect(@book.errors.full_messages).to include "Publisher can't be blank"
    end

    it 'カテゴリーが空だと編集ができない' do
      @book.category_id = ''
      @book.valid? 
      expect(@book.errors.full_messages).to include "Category is Unselected"
    end

    it 'userが紐づいていないと編集ができない' do
      @book.user = nil
      @book.valid?
      expect(@book.errors.full_messages).to include "User must exist"
    end
  end
end

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  context 'お気に入り登録ができる時' do
    it '値が一意であればお気に入り登録ができる' do
    user = FactoryBot.build(:user)
    book = FactoryBot.build(:book)
    user.id = 1
    book.id = 1
    user.save
    book.save
    favorite = FactoryBot.build(:favorite, user_id: user.id, book_id: book.id)
    favorite.save

    another_book = FactoryBot.build(:book)
    another_book.id = 2
    another_book.save
    another_fav = FactoryBot.build(:favorite, user_id: user.id, book_id: another_book.id)
    expect(another_fav).to be_valid
    end
  end

  context 'お気に入り登録ができない時' do
    it '値が一意でなければお気に入り登録ができない' do
      @favorite.save
      another_fav = FactoryBot.build(:favorite)
      another_fav.user_id = @favorite.user_id
      another_fav.book_id = @favorite.book_id
      another_fav.valid? 
      expect(another_fav.errors.full_messages).to include "User has already been taken"
    end

    it 'user_idが紐づいていないとお気に入り登録ができない' do
      @favorite.user = nil
      @favorite.valid?
      expect(@favorite.errors.full_messages).to include "User must exist"
    end

    it 'book_idが紐づいていないとお気に入り登録ができない' do
      @favorite.book = nil
      @favorite.valid?
      expect(@favorite.errors.full_messages).to include "Book must exist"
    end
  end
end

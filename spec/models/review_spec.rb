require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  context 'レビューの編集ができる時' do
    it 'すべての値が正しく入力されていれば編集ができる' do
      expect(@review).to be_valid
    end
  end

  context 'レビューの編集ができない時' do
    it 'レビューが空だと編集ができない' do
      @review.content = ''
      @review.valid? 
      expect(@review.errors.full_messages).to include "Content can't be blank"
    end

    it 'book_idが紐づいていないと編集ができない' do
      @review.book = nil
      @review.valid?
      expect(@review.errors.full_messages).to include "Book must exist"
    end
  end
end

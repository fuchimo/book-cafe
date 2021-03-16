require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  context '住所の登録・編集ができる時' do
    it 'すべての値が正しく入力されていれば登録・編集ができる' do
      expect(@address).to be_valid
    end

    it '建物名が空白でも登録・編集ができる' do
      @address.building_number = ''
      expect(@address).to be_valid
    end
  end

  context '住所の登録・編集ができない時' do
    it '郵便番号が空だと登録・編集ができない' do
      @address.postal_code = ''
      @address.valid?
      expect(@address.errors.full_messages).to include "Postal code can't be blank"
    end

    it '都道府県が空だと登録・編集ができない' do
      @address.prefecture_id = ''
      @address.valid?
      expect(@address.errors.full_messages).to include 'Prefecture is Unselected'
    end

    it '市区町村が空だと登録・編集ができない' do
      @address.city = ''
      @address.valid?
      expect(@address.errors.full_messages).to include "City can't be blank"
    end

    it '番地が空だと登録・編集ができない' do
      @address.house_number = ''
      @address.valid?
      expect(@address.errors.full_messages).to include "House number can't be blank"
    end

    it '郵便番号に「-」がないと登録・編集ができない' do
      @address.postal_code = '12345678'
      @address.valid?
      expect(@address.errors.full_messages).to include 'Postal code is invalid'
    end

    it '郵便番号が全角数字だと登録・編集ができない' do
      @address.postal_code = '１２３４-５６７８'
      @address.valid?
      expect(@address.errors.full_messages).to include 'Postal code is invalid'
    end

    it '郵便番号が半角英数字混合だと登録・編集ができない' do
      @address.postal_code = '123-aaaa'
      @address.valid?
      expect(@address.errors.full_messages).to include 'Postal code is invalid'
    end

    it '郵便番号が半角英字だと登録・編集ができない' do
      @address.postal_code = 'aaa-aaaa'
      @address.valid?
      expect(@address.errors.full_messages).to include 'Postal code is invalid'
    end
  end
end

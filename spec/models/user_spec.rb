require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context '次のページに遷移できる時' do
    it 'すべての値が正しく入力されていれば次のページに遷移ができる' do
      expect(@user).to be_valid
    end
  end

  context '次のページに遷移できない時' do
    it 'nicknameが空だと次のページに遷移ができない' do
      @user.nickname = ''
      @user.valid? 
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'emailが空だと次のページに遷移ができない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'emailが既存のデータと重複していると次のページに遷移ができない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include 'Email has already been taken'
    end

    it 'emailに＠がないと次のページに遷移ができない' do
      @user.email = 'samplesample'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end

    it 'passwordが空だと次のページに遷移ができない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'passwordが6文字以下だと次のページに遷移ができない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end

    it 'birth_dateが空白だと登録ができない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end
  end
end

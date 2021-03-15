require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @address = FactoryBot.build(:address)
  end

  context 'ユーザーの新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      #トップページに移動する
      visit_with_http_auth root_path

      #新規登録ボタンがある
      expect(page).to have_content('新規登録')

      #新規登録ページへ移動する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password_confirmation', with: @user.password_confirmation
      select '2000', from: 'user_birth_date_1i'
      select '1', from: 'user_birth_date_2i'
      select '1', from: 'user_birth_date_3i'

      #nextボタンをクリックすると住所入力ページへ遷移する
      find('input[name="commit"]').click
      expect(current_path).to eq user_registration_path

      #住所情報を入力する
      fill_in 'postal_code', with: @address.postal_code
      select '北海道', from: 'prefecture_id'
      fill_in 'city', with: @address.city
      fill_in 'house_number', with: @address.house_number
      fill_in 'building_number', with: @address.building_number

      #sign upをクリックすると、ユーザーモデルとアドレスモデルのカウントが1上がる
      expect {
        find('input[name="commit"]').click
      }.to change { User.count Address.count }.by(1)

      #トップページに遷移する
      expect(current_path).to eq root_path

      #ログアウトボタンとマイページボタンがある
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('マイページ')

      #新規登録ボタンとログインボタンがない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザーの新規登録ができない時' do
    it '謝ったユーザー情報ではユーザー新規登録ができずに入力画面に戻ってくる' do
      #トップページに移動する
      visit_with_http_auth root_path

      #新規登録ボタンがある
      expect(page).to have_content('新規登録')

      #新規登録ページへ移動する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password_confirmation', with: ''

      #nextボタンをクリックすると入力ページへ戻ってくる
      find('input[name="commit"]').click
      expect(current_path).to eq ('/users')
    end

    it '謝った住所情報ではユーザー新規登録ができずに入力画面に戻ってくる' do
      #トップページに移動する
      visit_with_http_auth root_path

      #新規登録ボタンがある
      expect(page).to have_content('新規登録')

      #新規登録ページへ移動する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password_confirmation', with: @user.password_confirmation
      select '2000', from: 'user_birth_date_1i'
      select '1', from: 'user_birth_date_2i'
      select '1', from: 'user_birth_date_3i'

      #nextボタンをクリックすると入力ページへ戻ってくる
      find('input[name="commit"]').click
      expect(current_path).to eq user_registration_path
      expect(current_path).to eq ('/users')

      #住所情報を入力する
      fill_in 'postal_code', with: ''
      fill_in 'city', with: ''
      fill_in 'house_number', with: ''
      fill_in 'building_number', with: ''

      #sign upをクリックしても、ユーザーモデルとアドレスモデルのカウントは変わらない
      expect {
        find('input[name="commit"]').click
      }.to change { User.count Address.count }.by(0)

      #入力ページへ戻ってくる
      expect(current_path).to eq ('/addresses')
    end
  end
end

RSpec.describe "ユーザーログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @address = FactoryBot.create(:address)
  end

  context 'ログインができる時' do
    it '正しい情報を入力すればユーザーログインができる' do
      #トップページに移動する
      visit_with_http_auth root_path

      #ログインボタンがある
      expect(page).to have_content('ログイン')

      #新規登録ページへ移動する
      visit new_user_session_path

      #ユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password

      #sign upボタンをクリックするとトップページへ遷移する
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      #ログアウトボタンとマイページボタンがある
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('マイページ')

      #新規登録ボタンとログインボタンがない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインができる時' do
    it '謝ったユーザー情報ではログインができずに入力画面に戻ってくる' do
      #トップページに移動する
      visit_with_http_auth root_path

      #ログインボタンがある
      expect(page).to have_content('ログイン')

      #新規登録ページへ移動する
      visit new_user_session_path

      #ユーザー情報を入力する
      fill_in 'email', with: ""
      fill_in 'password', with: ""

      #sign upボタンをクリックするとログインページに戻される
      find('input[name="commit"]').click
      expect(current_path).to eq new_user_session_path
    end
  end
end

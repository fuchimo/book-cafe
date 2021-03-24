require 'rails_helper'

RSpec.describe "レビュー投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.build(:book)
    @review = FactoryBot.build(:review)
    sleep(0.5)
  end

  context 'レビューが投稿できる時' do
    it 'ログインしたユーザーはレビューの投稿ができる' do
      # ログインする
      sign_in(@user)

      # 投稿ページへのボタンがある
      expect(page).to have_content('レビューを投稿する')

      # 新規投稿ページへ移動する
      visit new_book_path

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test-img.png')

      # フォームに情報を入力する
      attach_file('book_review[image]', image_path, make_visible: true)
      fill_in 'book-title', with: @book.title
      fill_in 'book-author', with: @book.author
      fill_in 'book-publisher', with: @book.publisher
      select 'ミステリー', from: 'book-category'
      fill_in 'review-text', with: @review.content

      # 送信するとbookモデルとreviewモデルのカウントが1上がる
      expect {
        find('input[name="commit"]').click
      }.to change { Book.count Review.count }.by(1)
      
      # トップページに遷移する
      expect(current_path).to eq root_path

      # トップページに投稿した内容が表示されている
      expect(page).to have_content(@book.title)
    end
  end

  context 'レビューが投稿できない時' do
    it 'ログインしていないユーザーはレビューの投稿ができない' do
      # トップページに移動する
      visit_with_http_auth root_path

      # 投稿ページへのボタンがない
      expect(page).to have_no_content('レビューを投稿する')
    end

    it '正しい情報を入力しなければレビューの投稿ができない' do
      # ログインする
      sign_in(@user)

      # 投稿ページへのボタンががある
      expect(page).to have_content('レビューを投稿する')

      # 新規投稿ページへ移動する
      visit new_book_path

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test-img.png')

      # フォームに情報を入力する
      attach_file('book_review[image]', image_path, make_visible: true)
      fill_in 'book-title', with: ''
      fill_in 'book-author', with: ''
      fill_in 'book-publisher', with: ''
      fill_in 'review-text', with: ''

      # 送信するとbookモデルとreviewモデルのカウントが変わらず入力画面に戻ってくる
      expect {
        find('input[name="commit"]').click
      }.to change { Book.count Review.count }.by(0)
      expect(current_path).to eq ('/books')
    end
  end
end
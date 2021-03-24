require 'rails_helper'

RSpec.describe "コメント投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.build(:book)
    @review = FactoryBot.build(:review)
  end

  context 'コメントが投稿できる時' do
    it 'ログインしたユーザーはコメントの投稿ができる' do
      # ログインする
      sign_in(@user)

      # 本を投稿する
      book_create(@book,@review)

      # 本の詳細ページへのボタンがある
      expect(page).to have_content('詳細')
      
      # 本の詳細ページへ移動する
      find('.card_btn').click

      # コメントを入力する
      fill_in 'comment_comment', with: "テストです"

      # 投稿ボタンをクリックするとコメントモデルのカウントが1上がる。
      expect {
        find('input[name="commit"]').click
        sleep(5)
      }.to change { Comment.count }.by(1)

      # 投稿したコメントが表示されている
      expect(page).to have_content("テストです")
    end
  end

  context 'コメントが投稿できない時' do
    it 'ログインしていないユーザーはコメントの投稿ができない' do
      # ログインする
      sign_in(@user)

      # 本を投稿する
      book_create(@book,@review)

      # 本の詳細ページへのボタンがある
      expect(page).to have_content('詳細')

      # ログアウトする
      click_link 'ログアウト'
      
      # 本の詳細ページへ移動する
      find('.card_btn').click

      # 投稿フォームがなくログインが必要ですの表示がある
      expect(page).to have_content('コメントの投稿にはログインが必要です')
    end

    it '正しい情報を入力しなければコメントの投稿ができない' do
      # ログインする
      sign_in(@user)

      # 本を投稿する
      book_create(@book,@review)

      # 本の詳細ページへのボタンがある
      expect(page).to have_content('詳細')
      
      # 本の詳細ページへ移動する
      find('.card_btn').click

      # コメントを入力する
      fill_in 'comment_comment', with: ""

      # 投稿ボタンをクリックしても保存されない
      expect {
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(0)
    end
  end
end

RSpec.describe "コメント削除機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.build(:book)
    @review = FactoryBot.build(:review)
  end

  context 'コメントが削除できる時' do
    it 'コメントした本人は自身のコメントの削除ができる' do
      # ログインする
      sign_in(@user)

      # 本を投稿する
      book_create(@book,@review)

      # 本の詳細ページへのボタンがある
      expect(page).to have_content('詳細')
      
      # 本の詳細ページへ移動する
      find('.card_btn').click

      # コメントを入力する
      fill_in 'comment_comment', with: "テストです"

      # 投稿ボタンをクリックするとコメントモデルのカウントが1上がる。
      expect {
        find('input[name="commit"]').click
        sleep(5)
      }.to change { Comment.count }.by(1)

      # 投稿したコメントが表示されている
      expect(page).to have_content("テストです")

      # 投稿したコメントの削除ボタンをクリックするとコメントが削除され、コメントモデルのカウントが1減る
      expect {
        find('.comment__delete--btn').click
        sleep(5)
      }.to change { Comment.count }.by(-1)
    end
  end

  context 'コメントが削除できない時' do
    it '投稿した本人でなければコメントの削除ができない' do
      # ログインする
      sign_in(@user)

      # 本を投稿する
      book_create(@book,@review)

      # ログアウトする
      click_link 'ログアウト'

      # 別のユーザーでログインする
      another_user = FactoryBot.create(:user)
      sign_in(another_user)

      # 本の詳細ページへのボタンがある
      expect(page).to have_content('詳細')

      # 本の詳細ページへ移動する
      find('.card_btn').click
      binding.pry

      # 削除ボタンがない
      expect(page).to have_no_content('削除')
    end
  end
end
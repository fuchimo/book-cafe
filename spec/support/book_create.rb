module BookCreate

  def book_create(book,review)
    expect(page).to have_content('レビューを投稿する')
    visit new_book_path
    image_path = Rails.root.join('public/images/test-img.png')

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
  end
end
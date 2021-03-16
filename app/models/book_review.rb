class BookReview
  include ActiveModel::Model 
  attr_accessor :title, :author, :publisher, :category_id, :image, :user_id, :content, :book_id

  with_options presence: true do 
    validates :title
    validates :author
    validates :publisher
    validates :image
    validates :content
    validates :user_id
  end

  validates :category_id, numericality: { only_integer: true, message: 'is Unselected' }

  def save
    book = Book.create(title: title, author: author, publisher: publisher, category_id: category_id, user_id: user_id, image: image)
    Review.create(content: content, book_id: book.id)
  end
  
end
class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :review, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do 
    validates :title
    validates :author
    validates :publisher
    validates :image
  end

  validates :category_id, numericality: { only_integer: true, message: 'is Unselected' }

end

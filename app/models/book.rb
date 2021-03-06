class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :review

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

end

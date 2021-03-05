class Book < ApplicationRecord
  has_many :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do 
    validates :title
    validates :author
    validates :publisher
  end

  validates :category_id, numericality: { only_integer: true, message: 'is Unselected' }

end

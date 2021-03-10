class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :review, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do 
    validates :title
    validates :author
    validates :publisher
    validates :image
  end

  validates :category_id, numericality: { only_integer: true, message: 'is Unselected' }

  def self.search(search)
    if search != ""
      Book.where(['title LIKE ? OR author LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Book.all
    end
  end
end

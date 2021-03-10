class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, :birth_date, presence: true
  
  has_many :books
  has_one :address
  has_many :comments
  has_many :favorites
  has_many :fav_books, through: :favorites, source: :book
  
end

class Address < ApplicationRecord
  belongs_to :user, optional: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  with_options presence: true do 
    validates :postal_code
    validates :city
    validates :house_number
  end

  validates :prefecture_id, numericality: { only_integer: true, message: 'is Unselected' }
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid', allow_blank: true }

end

class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ミステリー'},
    { id: 2, name: 'サスペンス'},
    { id: 3, name: '恋愛'},
    { id: 4, name: 'SF'},
    { id: 5, name: 'ファンタジー'},
    { id: 6, name: '青春'},
    { id: 7, name: 'ホラー'},
    { id: 8, name: '時代・歴史'},
    { id: 9, name: 'ビジネス'},
    { id: 10, name: 'ノンフィクション'},
    { id: 11, name: '自己啓発'},
  ]

  include ActiveHash::Associations
  has_many :books
end
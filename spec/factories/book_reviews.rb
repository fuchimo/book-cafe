FactoryBot.define do
  factory :book_review do
    title { 'test' }
    author { 'test' }
    publisher { 'test' }
    category_id { 1 }
    content { 'test' }
  end
end

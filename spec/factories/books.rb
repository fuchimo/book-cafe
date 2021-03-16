FactoryBot.define do
  factory :book do
    title { 'test' }
    author { 'test' }
    publisher { 'test' }
    category_id { 1 }

    association :user

    after(:build) do |book|
      book.image.attach(io: File.open('public/images/test-img.png'), filename: 'test-img.png')
    end
  end
end

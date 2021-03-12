FactoryBot.define do
  factory :review do
    content { 'test' }

    association :book
  end
end

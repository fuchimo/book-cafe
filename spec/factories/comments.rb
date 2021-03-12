FactoryBot.define do
  factory :comment do
    comment { 'test' }

    association :user
    association :book
  end
end

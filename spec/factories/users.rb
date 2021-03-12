FactoryBot.define do
  factory :user do
    nickname { 'sample' }
    email { Faker::Internet.free_email }
    password { 'pass1234' }
    password_confirmation { password }
    birth_date { '2000/1/1' }
  end
end

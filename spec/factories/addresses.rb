FactoryBot.define do
  factory :address do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '京都市' }
    house_number { '青山1-1' }
    building_number { '柳ビル' }
    
    association :user
    
  end
end

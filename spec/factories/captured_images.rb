FactoryGirl.define do

  factory :captured_image do
    content   {File.open("#{Rails.root}/spec/fixtures/sample.png")}
    id        {Faker::Number.number(3)}

    trait :main do
      status 0
    end

    trait :sub do
      status 1
    end
  end
end

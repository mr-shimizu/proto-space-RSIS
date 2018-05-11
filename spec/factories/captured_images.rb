FactoryGirl.define do
  factory :captured_image, class: CapturedImage do
    content ("spec/fixtures/img/sample.png")

    trait :main do
      status   :main
    end

    trait :sub do
      status   :sub
    end

    factory :main_image, traits: [:main]
    factory :sub_image, traits: [:sub]
  end
end

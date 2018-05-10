FactoryGirl.define do

  factory :prototype do
    title        {Faker::Lorem.word}
    catch_copy   {Faker::Lorem.sentence}
    concept      {Faker::Lorem.sentence}
    created_at   {Faker::Time.between(2.days.ago, Time.now, :all)}
    user

    trait :with_sub_images do
      transient do
        sub_images_count 3
      end

      after(:create) do |prototype, evaluator|
        prototype.captured_images << create_list(:sub_image, evaluator.sub_images_count)
      end
    end

    trait :with_tags do
      transient do
        tags_count 3
      end

      after(:create) do |prototype, evaluator|
        prototype.tags << create_list(:tag, evaluator.tags_count)
      end
    end

    trait :with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |prototype, evaluator|
        prototype.comments << create_list(:comment, evaluator.comments_count)
      end
    end

    trait :with_likes do
      transient do
        likes_count 5
      end

      after(:create) do |prototype, evaluator|
        prototype.likes << create_list(:like, evaluator.likes_count)
      end
    end
  end
end

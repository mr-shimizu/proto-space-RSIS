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
        evaluator.sub_images_count do
          prototype.sub_images.create!
        end
      end
    end

    trait :with_tags do
      transient do
        tags_count 3
      end

      after(:create) do |prototype, evaluator|
        evaluator.tags_count do
          prototype.tags.create!
        end
      end
    end

    trait :with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |prototype, evaluator|
        evaluator.comments_count.times do
          prototype.comments.create!
        end
      end
    end

    trait :with_likes do
      transient do
        likes_count 5
      end

      after(:create) do |prototype, evaluator|
        evaluator.likes_count.times do
          prototype.likes.create!
        end
      end
    end
  end
end

FactoryGirl.define do

  factory :prototype do
    title        {Faker::Lorem.word}
    catch_copy   {Faker::Lorem.sentence}
    concept      {Faker::Lorem.sentence}
    user
    created_at   {Faker::Time.between(2.days.ago, Time.now, :all)}
    likes_count  nil
  end
end

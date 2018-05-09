FactoryGirl.define do
  factory :prototype do
    title {Faker::Lorem.word}
    catch_copy {Faker::Lorem.sentence}
    concept {Faker::Lorem.sentence}
    user
    tag_list nil#{Faker::Lorem.words(3)}
    # captured_images_attributes [:content, :status, :id]
    created_at {Faker::Time.between(2.days.ago, Time.now, :all)}
  end
end

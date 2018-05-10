FactoryGirl.define do

  factory :user do
    name                  {Faker::Internet.user_name(3..20)}
    email                 {Faker::Internet.email}
    password              "password"
    password_confirmation "password"
  end
end

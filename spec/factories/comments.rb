FactoryGirl.define do

  factory :comment do
    content  {Faker::OnePiece.character}
    user
    prototype
  end
end

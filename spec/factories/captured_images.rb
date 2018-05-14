FactoryGirl.define do

  factory :captured_image do
    content Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg'))
    status
    prototype
  end
end

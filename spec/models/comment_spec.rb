require 'rails_helper'

describe Comment do

  let(:user) {create(:user)}
  let(:prototype) {create(:prototype)}
  let(:comment) {build(:comment)}
  describe '#create' do

    it "is valid with a content" do
      expect(comment).to be_valid
    end

    it "is invalid without a content" do
      comment[:content] = ""
      comment.valid?
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end
end

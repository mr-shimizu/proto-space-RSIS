require 'rails_helper'

describe User do

  describe '#create' do

    it "is valid with a name, an email, a password and a password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a password and without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid with an email which has been taken" do
      userA = create(:user, email: "aaa@yahoo.co.jp")
      userB = build(:user, email: "aaa@yahoo.co.jp")
      userB.valid?
      expect(userB.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a name having less than 3 characters" do
      user = build(:user, name: "12")
      user.valid?
      expect(user.errors[:name]).to include("is too short (minimum is 3 characters)")
    end

    it "is valid with a name having greater than or equal to 3 characters" do
      user = build(:user, name: "123")
      expect(user).to be_valid
    end

    it "is invalid with a name having greater than 20 characters" do
      user = build(:user, name: "123456789012345678901")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is valid with a name having less than or equal to 20 characters" do
      user = build(:user, name: "12345678901234567890")
      expect(user).to be_valid
    end

    it "is invalid with a password having less than 6 characters" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "is valid with a password having greater than or equal 6 characters" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

  end
end

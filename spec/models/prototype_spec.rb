require 'rails_helper'

describe Prototype do
  describe 'associations' do
    it 'is assocciated with a user' do
      user = create(:user)
      prototype = create(:prototype, user: user)
      expect(prototype.user) == user
    end
  end

  describe 'validations' do
    context 'validations exist' do
      it 'has the validations' do
        prototype = build(:prototype)
        expect(prototype).to be_valid
      end
    end

    context 'without validations' do
      it 'does not have title' do
        prototype = build(:prototype, title: nil)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end

      it 'does not have catch_copy' do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end

      it 'does not have concept' do
        prototype = build(:prototype, concept: nil)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end

  describe '#like_user(user_id)' do
    context 'when like_user is the user' do
      it 'like_user is the user' do
        user = create(:user)
        prototype = create(:prototype, user: user)
        like = create(:like, prototype: prototype, user: user)
        expect(prototype.like_user(user)) == user
      end
    end

    context 'when like_user is not the user' do
      it 'like_user is not the user' do
        user = create(:user)
        another_user = create(:user, id: user.id + 1)
        prototype = create(:prototype, user: another_user)
        like = create(:like, prototype: prototype, user: another_user)
        expect(prototype.like_user(user)).not_to eq user
      end
    end
  end
end

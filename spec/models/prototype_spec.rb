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
end

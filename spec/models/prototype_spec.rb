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
  end
end

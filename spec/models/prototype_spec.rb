require 'rails_helper'

describe Prototype do
  describe 'associations' do
    it 'is assocciated with a user' do
      user = create(:user)
      prototype = create(:prototype, user: user)
      expect(prototype.user).to eq user
    end
  end
end

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    subject { build(:admin) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }

    context 'email uniqueness' do
      before { create(:admin) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:admin)).to be_valid
    end

    it 'is invalid without a name' do
      admin = build(:admin, name: nil)
      expect(admin).not_to be_valid
    end

    it 'is invalid without an email' do
      admin = build(:admin, email: nil)
      expect(admin).not_to be_valid
    end

    it 'is invalid with a duplicate email' do
      create(:admin, email: 'test@example.com')
      admin = build(:admin, email: 'test@example.com')
      expect(admin).not_to be_valid
    end
  end

  describe 'password validation' do
    it 'is invalid with a short password' do
      admin = build(:admin, password: '123', password_confirmation: '123')
      expect(admin).not_to be_valid
    end

    it 'is invalid with mismatched password confirmation' do
      admin = build(:admin, password: 'password123', password_confirmation: 'different')
      expect(admin).not_to be_valid
    end
  end
end

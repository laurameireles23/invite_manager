require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'validations' do
    subject { build(:invitation) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:status) }

    it 'validates email format' do
      invitation = build(:invitation, email: 'invalid_email')
      expect(invitation).not_to be_valid
      expect(invitation.errors[:email]).to include('não é válido')
    end
  end

  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:admin) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:invitation)).to be_valid
    end

    it 'is invalid without a name' do
      invitation = build(:invitation, name: nil)
      expect(invitation).not_to be_valid
    end

    it 'is invalid without an email' do
      invitation = build(:invitation, email: nil)
      expect(invitation).not_to be_valid
    end

    it 'is invalid without a status' do
      invitation = build(:invitation, status: nil)
      expect(invitation).not_to be_valid
    end
  end

  describe 'status management' do
    it 'sets disable_at when status changes to cancelled' do
      invitation = create(:invitation)

      travel_to Time.current do
        invitation.update(status: 'cancelled')
        expect(invitation.disable_at).to eq(Time.zone.now)
      end
    end

    it 'does not set disable_at when status changes to other status' do
      invitation = create(:invitation)
      original_disable_at = invitation.disable_at

      invitation.update(status: 'accepted')
      expect(invitation.disable_at).to eq(original_disable_at)
    end

    describe 'status_label' do
      it 'returns correct label for pending status' do
        invitation = build(:invitation, status: 'pending')
        expect(invitation.status_label).to eq('Pendente')
      end

      it 'returns correct label for accepted status' do
        invitation = build(:invitation, status: 'accepted')
        expect(invitation.status_label).to eq('Aceito')
      end

      it 'returns correct label for cancelled status' do
        invitation = build(:invitation, status: 'cancelled')
        expect(invitation.status_label).to eq('Cancelado')
      end
    end
  end
end

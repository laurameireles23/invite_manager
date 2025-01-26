require 'rails_helper'

RSpec.describe CreateService do
  let(:valid_attributes) { attributes_for(:company) }
  let(:invalid_attributes) { attributes_for(:company, name: nil) }

  describe "#call" do
    context "when given valid attributes" do
      it "creates a new record and returns success" do
        service = CreateService.new(Company, valid_attributes)
        result = service.call

        expect(result.success?).to be true
        expect(result.record).to be_a(Company)
        expect(result.record).to be_persisted
      end
    end

    context "when given invalid attributes" do
      it "does not create a new record and returns failure" do
        service = CreateService.new(Company, invalid_attributes)
        result = service.call

        expect(result.success?).to be false
        expect(result.record).to be_a(Company)
        expect(result.record.persisted?).to be false
      end
    end
  end
end

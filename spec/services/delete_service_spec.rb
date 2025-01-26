require 'rails_helper'

RSpec.describe DestroyService do
  let!(:company) { create(:company) }

  describe "#call" do
    context "when the record is destroyed successfully" do
      it "destroys the record and returns success" do
        service = DestroyService.new(company)
        result = service.call

        expect(result.success?).to be true
        expect(Company.exists?(company.id)).to be false
      end
    end

    context "when the record cannot be destroyed" do
      it "returns failure" do
        allow(company).to receive(:destroy).and_return(false)  # Simula falha na destruição
        service = DestroyService.new(company)
        result = service.call

        expect(result.success?).to be false
        expect(Company.exists?(company.id)).to be true
      end
    end
  end
end

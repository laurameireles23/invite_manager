require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:invitations).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cnpj) }
    it { is_expected.to validate_uniqueness_of(:cnpj) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }


    context "with a valid CNPJ" do
      let(:company) { build(:company, cnpj: CNPJ.generate(format: true)) }

      it "is valid" do
        expect(company).to be_valid
      end
    end

    context "with an invalid CNPJ" do
      let(:company) { build(:company, cnpj: "12345678901234") }

      it "is invalid" do
        expect(company).to be_invalid
        expect(company.errors[:cnpj]).to include("não é válido")
      end
    end
  end

  describe "#decorate" do
    let(:company) { build(:company) }

    it "returns a decorated company object" do
      decorated_company = company.decorate
      expect(decorated_company).to be_an_instance_of(CompanyDecorator)
      expect(decorated_company.company).to eq(company)
    end
  end
end

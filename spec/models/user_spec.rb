require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one_attached(:avatar) }

  it { should define_enum_for(:gender).with_values(male: 0, female: 1, other: 2) }

  describe 'validations' do
    let(:user) { FactoryBot.build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    context 'when creating a new record' do
      it { should validate_presence_of(:role) }
      it { should validate_inclusion_of(:role).in_array(['Doctor', 'Patient']) }
      it { should validate_presence_of(:type) }
    end

    context 'when type has changed' do
      it 'validates presence of type' do
        user.type = 'Patient'
        expect(user).to validate_presence_of(:type)
      end
    end
  end

  describe '#name' do
    let(:user) { FactoryBot.create(:user, email: 'johndoe@example.com', name: nil) }

    it 'returns the part of the email before the @ if name is nil' do
      expect(user.name).to eq 'johndoe'
    end

    it 'returns the name if it is not nil' do
      user.name = 'John Doe'
      expect(user.name).to eq 'John Doe'
    end
  end
end

require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'associations' do
    it { should have_many(:appointments) }
    it { should have_one(:patient_profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:patient_profile) }
  end
end

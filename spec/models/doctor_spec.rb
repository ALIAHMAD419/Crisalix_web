require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'associations' do
    it { should have_many(:appointments) }
    it { should have_one(:doctor_profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:doctor_profile) }
  end
end

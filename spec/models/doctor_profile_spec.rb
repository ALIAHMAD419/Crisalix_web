require 'rails_helper'

RSpec.describe DoctorProfile, type: :model do
  describe 'associations' do
    it { should belong_to(:doctor).class_name('User').with_foreign_key('doctor_id').dependent(:destroy) }
  end
end

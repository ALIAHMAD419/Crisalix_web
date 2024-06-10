require 'rails_helper'

RSpec.describe PatientProfile, type: :model do
  describe 'associations' do
    it { should belong_to(:patient).class_name('User').with_foreign_key('patient_id').dependent(:destroy) }
  end
end

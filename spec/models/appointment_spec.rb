require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'associations' do
    it { should belong_to(:doctor).class_name('User').with_foreign_key('doctor_id') }
    it { should belong_to(:patient).class_name('User').with_foreign_key('patient_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:appointment_date) }
    it { should validate_presence_of(:status) }

    context 'when doctor appointments overlap' do
      let(:doctor) { FactoryBot.create(:user) }
      let(:patient) { FactoryBot.create(:user) }
      let(:existing_appointment) { FactoryBot.create(:appointment, doctor: doctor, appointment_date: '2024-06-15 10:00:00') }
      let(:appointment) { FactoryBot.build(:appointment, doctor: doctor, patient: patient, appointment_date: '2024-06-15 10:00:00') }

      before { existing_appointment }

      it 'validates appointment date does not overlap for the same doctor' do
        appointment.valid?
        expect(appointment.errors[:appointment_date]).to include('conflicts with another appointment for this doctor.')
      end
    end

    context 'when patient appointments overlap' do
      let(:doctor) { FactoryBot.create(:user) }
      let(:patient) { FactoryBot.create(:user) }
      let(:existing_appointment) { FactoryBot.create(:appointment, patient: patient, appointment_date: '2024-06-15 10:00:00') }
      let(:appointment) { FactoryBot.build(:appointment, doctor: doctor, patient: patient, appointment_date: '2024-06-15 10:00:00') }

      before { existing_appointment }

      it 'validates appointment date does not overlap for the same patient' do
        appointment.valid?
        expect(appointment.errors[:appointment_date]).to include('conflicts with another appointment for this patient.')
      end
    end
  end
end

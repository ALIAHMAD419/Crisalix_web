require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:patient) { FactoryBot.create(:patient) }

  describe 'GET #show_patient' do
    let(:appointment) { FactoryBot.create(:appointment) }

    before { sign_in appointment.patient }

    it 'assigns the requested appointment to @appointment' do
      get :show_patient, params: { id: appointment.id }
      expect(assigns(:appointment)).to eq(appointment)
    end
  end
    
end

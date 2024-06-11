require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:patient) { FactoryBot.create(:patient) }
  let(:doctor) { FactoryBot.create(:doctor) }

  before do
    sign_in patient
  end

  describe 'GET #show_patient' do
    it 'assigns the requested appointment to @appointment' do
      appointment = FactoryBot.create(:appointment, patient: patient)
      get :show_patient, params: { id: appointment.id }
      expect(assigns(:appointment)).to eq(appointment)
    end

    it 'assigns the patient of the appointment to @patient' do
      appointment = FactoryBot.create(:appointment, patient: patient)
      get :show_patient, params: { id: appointment.id }
      expect(assigns(:patient)).to eq(appointment.patient)
    end

    it 'renders the show_patient template' do
      appointment = FactoryBot.create(:appointment, patient: patient)
      get :show_patient, params: { id: appointment.id }
      expect(response).to render_template('show_patient')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested patient to @patient' do
      get :show, params: { id: patient.id }
      expect(assigns(:patient)).to eq(patient)
    end

    it 'renders the show template' do
      get :show, params: { id: patient.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested patient to @patient' do
      get :edit, params: { id: patient.id }
      expect(assigns(:patient)).to eq(patient)
    end

    it 'renders the edit template' do
      get :edit, params: { id: patient.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Updated Name' } }

      it 'updates the patient' do
        patch :update, params: { id: patient.id, patient: valid_params }
        patient.reload
        expect(patient.name).to eq('Updated Name')
      end

      it 'redirects to the updated patient' do
        patch :update, params: { id: patient.id, patient: valid_params }
        expect(response).to redirect_to(patient)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil } }

      it 'does not update the patient' do
        original_name = patient.name
        patch :update, params: { id: patient.id, patient: invalid_params }
        patient.reload
        expect(patient.name).to eq(original_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the patient' do
      patient # create the patient
      expect {
        delete :destroy, params: { id: patient.id }
      }.to change(Patient, :count).by(-1)
    end

    it 'redirects to the patients index' do
      delete :destroy, params: { id: patient.id }
      expect(response).to redirect_to(patients_url)
    end
  end

  describe 'GET #edit_password' do
    it 'renders the edit_password template' do
      get :edit_password, params: { id: patient.id }
      expect(response).to render_template('edit_password')
    end
  end

  describe 'PATCH #update_password' do
    context 'with valid parameters' do
      let(:valid_password_params) { { current_password: 'password', password: 'newpassword', password_confirmation: 'newpassword' } }
    end

    context 'with invalid parameters' do
      let(:invalid_password_params) { { current_password: 'wrongpassword', password: 'newpassword', password_confirmation: 'newpassword' } }

      it 'does not update the patient password' do
        patch :update_password, params: { id: patient.id, patient: invalid_password_params }
        expect(response).to render_template('edit_password')
        expect(response.status).to eq(422)
      end
    end
  end
end

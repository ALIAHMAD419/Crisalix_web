require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:doctor) { FactoryBot.create(:doctor) }

  before do
    sign_in doctor
  end

  describe 'GET #show' do
    it 'assigns the requested doctor to @doctor' do
      get :show, params: { id: doctor.id }
      expect(assigns(:doctor)).to eq(doctor)
    end

    it 'renders the show template' do
      get :show, params: { id: doctor.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested doctor to @doctor' do
      get :edit, params: { id: doctor.id }
      expect(assigns(:doctor)).to eq(doctor)
    end

    it 'renders the edit template' do
      get :edit, params: { id: doctor.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { FactoryBot.attributes_for(:doctor) }
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Updated Name' } }

      it 'updates the doctor' do
        patch :update, params: { id: doctor.id, doctor: valid_params }
        doctor.reload
        expect(doctor.name).to eq('Updated Name')
      end

      it 'redirects to the updated doctor' do
        patch :update, params: { id: doctor.id, doctor: valid_params }
        expect(response).to redirect_to(doctor)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil } }

      it 'does not update the doctor' do
        original_name = doctor.name
        patch :update, params: { id: doctor.id, doctor: invalid_params }
        doctor.reload
        expect(doctor.name).to eq(original_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the doctor' do
      doctor # create the doctor
      expect {
        delete :destroy, params: { id: doctor.id }
      }.to change(Doctor, :count).by(-1)
    end

    it 'redirects to the doctors index' do
      delete :destroy, params: { id: doctor.id }
      expect(response).to redirect_to(doctors_url)
    end
  end

  describe 'GET #edit_password' do
    it 'renders the edit_password template' do
      get :edit_password, params: { id: doctor.id }
      expect(response).to render_template('edit_password')
    end
  end

  describe 'PATCH #update_password' do
    context 'with valid parameters' do
      let(:valid_password_params) { { current_password: 'password', password: 'newpassword', password_confirmation: 'newpassword' } }
    end

    context 'with invalid parameters' do
      let(:invalid_password_params) { { current_password: 'wrongpassword', password: 'newpassword', password_confirmation: 'newpassword' } }

      it 'does not update the doctor password' do
        patch :update_password, params: { id: doctor.id, doctor: invalid_password_params }
        expect(response).to render_template('edit_password')
        expect(response.status).to eq(422)
      end
    end
  end
end

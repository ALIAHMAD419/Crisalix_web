require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:patient) { FactoryBot.create(:patient) }
  let(:doctor) { FactoryBot.create(:doctor) }
  let(:appointment) { FactoryBot.create(:appointment, patient: patient, doctor: doctor) }

  before do
    sign_in patient
  end

  describe 'GET #index' do
    it 'assigns the appointments of the current user to @appointments' do
      get :index
      expect(assigns(:appointments)).to eq(patient.appointments)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested appointment to @appointment' do
      get :show, params: { id: appointment.id }
      expect(assigns(:appointment)).to eq(appointment)
    end

    it 'renders the show template' do
      get :show, params: { id: appointment.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'assigns a new appointment to @appointment' do
      get :new
      expect(assigns(:appointment)).to be_a_new(Appointment)
    end

    it 'assigns all doctors to @doctors' do
      get :new
      expect(assigns(:doctors)).to eq(Doctor.all)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { FactoryBot.attributes_for(:appointment).merge(doctor_id: doctor.id) }

      it 'creates a new appointment' do
        expect {
          post :create, params: { appointment: valid_params }
        }.to change(Appointment, :count).by(1)
      end

      it 'assigns the new appointment to the current user as patient' do
        post :create, params: { appointment: valid_params }
        expect(Appointment.last.patient).to eq(patient)
      end

      it 'redirects to the created appointment' do
        post :create, params: { appointment: valid_params }
        expect(response).to redirect_to(Appointment.last)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { FactoryBot.attributes_for(:appointment, appointment_date: nil) }

      it 'does not create a new appointment' do
        expect {
          post :create, params: { appointment: invalid_params }
        }.to_not change(Appointment, :count)
      end

      it 'renders the new template' do
        post :create, params: { appointment: invalid_params }
        expect(response).to render_template('new')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested appointment to @appointment' do
      get :edit, params: { id: appointment.id }
      expect(assigns(:appointment)).to eq(appointment)
    end

    it 'assigns all doctors to @doctors' do
      get :edit, params: { id: appointment.id }
      expect(assigns(:doctors)).to eq(Doctor.all)
    end

    it 'renders the edit template' do
      get :edit, params: { id: appointment.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { appointment_date: Date.tomorrow } }

      it 'updates the appointment' do
        patch :update, params: { id: appointment.id, appointment: valid_params }
        appointment.reload
        expect(appointment.appointment_date).to eq(Date.tomorrow)
      end

      it 'redirects to the updated appointment' do
        patch :update, params: { id: appointment.id, appointment: valid_params }
        expect(response).to redirect_to(appointment)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { appointment_date: nil } }

      it 'does not update the appointment' do
        original_date = appointment.appointment_date
        patch :update, params: { id: appointment.id, appointment: invalid_params }
        appointment.reload
        expect(appointment.appointment_date).to eq(original_date)
      end

      it 'renders the edit template' do
        patch :update, params: { id: appointment.id, appointment: invalid_params }
        expect(response).to render_template('edit')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the appointment' do
      appointment # create the appointment
      expect {
        delete :destroy, params: { id: appointment.id }
      }.to change(Appointment, :count).by(-1)
    end

    it 'redirects to the appointments index' do
      delete :destroy, params: { id: appointment.id }
      expect(response).to redirect_to(appointments_url)
    end
  end
end

class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: %i[show edit update destroy edit_password update_password]
  before_action :ensure_patient!, except: :show_patient


  def show_patient
    @appointment =  Appointment.find_by_id(params[:id])
    @patient = @appointment.patient
  end

  def show
  end

  def new
    @patient = current_user.build_patient
  end

  def edit
  end

  def create
    @patient = current_user.build_patient(patient_params)

    if @patient.save
      redirect_to @patient, notice: 'Patient profile was successfully created.'
    else
      render :new
    end
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient profile was successfully updated.'
    else
      render :edit
    end
  end

  def edit_password
    render 'edit_password'
  end

  def update_password
    if @patient.update_with_password(patient_password_params)
      bypass_sign_in(@patient)
      redirect_to @patient, notice: 'Password was successfully updated.'
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Patient profile was successfully destroyed.'
  end

  private

  def set_patient
    @patient = current_user
  end

  def patient_params
    params.require(:patient).permit(:name, :gender, :phone_number, :address, patient_profile_attributes: [:id, :medical_history, :date_of_birth, :blood_type, :allergies, :emergency_contact_name, :emergency_contact_phone, :insurance_provider])
  end

  def ensure_patient!
    unless user_patient?
      redirect_to root_path, alert: 'Access restricted to patients only.'
    end
  end

  def patient_password_params
    params.require(:patient).permit(:current_password, :password, :password_confirmation)
  end
end

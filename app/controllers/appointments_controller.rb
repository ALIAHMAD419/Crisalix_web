class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  before_action :set_doctors, only: %i[new edit create update]
  before_action :ensure_patient!, only: %i[new edit create update]


  def index
    @appointments = current_user.appointments
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient_id = current_user.id

    if @appointment.save
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    remove_attached_images
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Appointment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :status, :doctor_id, :image1, :image2, :image3)
  end

  def remove_attached_images
    @appointment.image1 = nil if params[:appointment][:remove_image1] == '1'
    @appointment.image2 = nil if params[:appointment][:remove_image2] == '1'
    @appointment.image3 = nil if params[:appointment][:remove_image3] == '1'
  end

  def authorize_user!
    unless current_user == @appointment.doctor || current_user == @appointment.patient
      redirect_to root_path, alert: 'Unauthorized access.'
    end
  end

  def set_doctors
    @doctors = Doctor.all
  end

  def ensure_patient!
    unless user_patient?
      redirect_to root_path, alert: 'Access restricted to patients only.'
    end
  end
end

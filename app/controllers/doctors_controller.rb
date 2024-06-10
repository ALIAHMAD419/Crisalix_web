# app/controllers/doctors_controller.rb
class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor, only: %i[show edit update destroy edit_password update_password]
  before_action :ensure_doctor!

  # def index
  #   @doctors = Doctor.all
  # end

  def show
  end

  def new
    @doctor = current_user.build_doctor
  end

  def edit

  end

  def create
    @doctor = current_user.build_doctor(doctor_params)

    if @doctor.save
      redirect_to @doctor, notice: 'Doctor profile was successfully created.'
    else
      render :new
    end
  end


  def update
    if @doctor.update(doctor_params)
      redirect_to @doctor, notice: 'Doctor profile was successfully updated.'
    else
      render :edit
    end
  end

  def edit_password
    render 'edit_password'
  end

  def update_password
    if @doctor.update_with_password(doctor_password_params)
      bypass_sign_in(@doctor)
      redirect_to @doctor, notice: 'Password was successfully updated.'
    else
      render :edit_password, status: :unprocessable_entity
    end
  end



  def destroy
    @doctor.destroy
    redirect_to doctors_url, notice: 'Doctor profile was successfully destroyed.'
  end

  private


  def set_doctor
    @doctor = current_user
  end

  def ensure_doctor!
    unless user_doctor?
      redirect_to root_path, alert: 'Access restricted to doctors only.'
    end
  end

  def doctor_params
    params.require(:doctor).permit(:name, :gender, :phone_number, :address, doctor_profile_attributes: [:id, :specialty, :bio])
  end

  def doctor_password_params
    params.require(:doctor).permit(:current_password, :password, :password_confirmation)
  end
end

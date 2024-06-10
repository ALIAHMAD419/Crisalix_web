class ApplicationController < ActionController::Base
  before_action :set_profile, :current_user_type, if: :user_signed_in?

  helper_method :user_doctor?, :user_patient?

  protected

  def user_doctor?
    user_signed_in? && current_user.type == 'Doctor'
  end

  def user_patient?
    user_signed_in? && current_user.type == 'Patient'
  end


  def current_user_model
    current_user.type.constantize if user_signed_in?
  end

  private

  def current_user_type
    @current_user_type = current_user.type if user_signed_in?
  end

  def set_profile
    if current_user.is_a?(Doctor)
      @profile = current_user.doctor_profile
    elsif current_user.is_a?(Patient)
      @profile = current_user.patient_profile
    end
  end
end

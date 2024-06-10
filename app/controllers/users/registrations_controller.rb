# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # POST /resource
  def create

    build_resource(sign_up_params)
    resource.role = params[:user][:role]

    if resource.role == 'Doctor'
      self.resource = Doctor.new(sign_up_params)
      if resource.save
        doctor_profile = resource.build_doctor_profile({})
        unless doctor_profile.save
          resource.errors.add(:base, "Doctor profile could not be created")
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    elsif resource.role == 'Patient'
      self.resource = Patient.new(sign_up_params)
      if resource.save
        patient_profile = resource.build_patient_profile({})
        unless patient_profile.save
          resource.errors.add(:base, "Patient profile could not be created")
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    end
    
    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if resource.role == 'Doctor'
      doctor_path(resource) # Redirect to the doctor creation page
    elsif resource.role == 'Patient'
      patient_path(resource)
    end
  end
end

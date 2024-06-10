class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader

  validates :appointment_date, presence: true
  validates :status, presence: true
  validate :appointment_date_does_not_overlap


  private
    def appointment_date_does_not_overlap
      doctor_appointments = Appointment.where(doctor_id: doctor_id).where.not(id: id)
      patient_appointments = Appointment.where(patient_id: patient_id).where.not(id: id)

      if doctor_appointments.exists?(appointment_date: appointment_date)
        errors.add(:appointment_date, "conflicts with another appointment for this doctor.")
      end

      if patient_appointments.exists?(appointment_date: appointment_date)
        errors.add(:appointment_date, "conflicts with another appointment for this patient.")
      end
    end
end

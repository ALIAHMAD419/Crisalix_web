class Patient < User
  has_many :appointments
  has_one :patient_profile, dependent: :destroy
  accepts_nested_attributes_for :patient_profile
end

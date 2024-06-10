class Doctor < User
  has_many :appointments
  has_one :doctor_profile, dependent: :destroy
  accepts_nested_attributes_for :doctor_profile
end

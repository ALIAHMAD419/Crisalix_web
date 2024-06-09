class Doctor < User
  has_one :doctor_profile, dependent: :destroy
  accepts_nested_attributes_for :doctor_profile
end

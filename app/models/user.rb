class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2, :github]

  has_one_attached :avatar
  attr_accessor :role
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ['Doctor', 'Patient'] }, if: -> { new_record? }
  validates :type, presence: true, if: -> { new_record? || type_changed? }
  enum gender: { male: 0, female: 1, other: 2 }


  self.inheritance_column = :type # Specify the column for STI


  def name
    @name ||= self[:name].presence || email.split("@").first
  end
end

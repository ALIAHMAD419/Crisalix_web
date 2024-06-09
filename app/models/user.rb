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
  validates :password, presence: true
  validates :role, presence: true, inclusion: { in: ['Doctor', 'Patient'] }
  validates :type, presence: true

  self.inheritance_column = :type # Specify the column for STI


  def name
    @name ||= self[:name].presence || email.split("@").first
  end

  # def self.from_omniauth(auth)
  #   data = auth.info

  #   User.where(email: data['email']).first_or_create do |user|
  #     user.name = data['name']
  #     user.password = Devise.friendly_token[0,20] if user.new_record?
  #   end
  # end

  # protected

  # def password_required?
  #   new_record? || password.present?
  # end
end

class Manager < ApplicationRecord

  BLACKLISTED_WORDS = File.readlines(Rails.root.join('config', 'blacklist.txt')).map(&:strip)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[a-zA-Z' ]*\z/
  VALID_USERNAME_REGEX = /\A[a-z0-9]*\z/
  
  validates :username, presence: true, length: { minimum: 3, maximum: 16 }, uniqueness: true, 
                       format: { with: VALID_USERNAME_REGEX }, 
                       exclusion: { in: BLACKLISTED_WORDS, message: "\"%{value}\" is blacklisted." }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 35 }, format: { with: VALID_NAME_REGEX }
  validates :last_name, presence: false, length: { maximum: 35 }, format: { with: VALID_NAME_REGEX }
  validates :dob, presence: true, timeliness: { before: lambda { 5.years.ago }, after: lambda { 120.years.ago }}
  validates :reg_ip, :last_ip, presence: false, length: { maximum: 45 }
  validates :online, :show_name, inclusion: { in: [true, false] }
  validates :country_id, presence: true
  
  belongs_to :country
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }
end
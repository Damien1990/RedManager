class Country < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  
  has_many :managers
end
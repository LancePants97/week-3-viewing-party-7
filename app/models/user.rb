class User <ApplicationRecord 
  validates_presence_of :email, :name, :password, :password_digest, :password_confirmation
  validates_uniqueness_of :email
  validates :name, uniqueness: true, presence: true

  has_many :viewing_parties
  has_secure_password
end 
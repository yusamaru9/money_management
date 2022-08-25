class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :month_records, dependent: :destroy
  has_many :day_records, dependent: :destroy
  has_many :day_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :password, presence: true, format: { with: VALID_PASSWORD_REGIX }
  
  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
end

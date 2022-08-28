class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  
  #deviseの上に置くことでバリデーションエラーメッセージの順番を名前が上にくる
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #ここにdeviseのバリデーションがある
         
  has_many :month_records, dependent: :destroy
  has_many :day_records, dependent: :destroy
  has_many :day_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  
  #ゲストログイン機能
  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
end
